require "json"
require "rest-client"
require "date"
require "yaml"

class Movies
  attr_reader :title, :year, :rated, :plot, :genres, :director, :writers, :actors, :poster, :runtime, :rating, :votes, :id
  
  def initialize(url, params = {})
    if params.keys.include?(:callback)
      raise ArgumentError.new("Passing the callback option makes not sense.")
    end
    
    @params = params
    
    if params.empty?
      @url = url
    else
      @url = "#{url}&#{(@params).map{|key, value| "#{key}=#{value}"}.join("&")}"
    end
  end

  def self.find_by_id(id, params = {})
    unless id.to_s.match(/tt\d{4,}/)
      raise ArgumentError.new("The id is not valid.")
    end
    Movies.new("http://www.imdbapi.com/?i=#{id}", params).prepare
  end
  
  def self.find_by_title(title, params = {})
    if title.nil? or title.empty?
      raise ArgumentError.new("Title can not be blank.")
    end
    Movies.new("http://www.imdbapi.com/?t=#{URI.encode(title)}", params).prepare
  end
    
  def self.find_by_release_name(title, params = {})
    if title.nil? or title.empty?
      raise ArgumentError.new("Title can not be blank.")
    end
    
    mf = MovieFilter.new(title: title)
    Movies.new("http://www.imdbapi.com/?t=#{URI.encode(mf.title)}", mf.to_param).prepare
  end
  
  def prepare
    tap do
      return self unless found?
      
      content.keys.each do |name| 
        instance_variable_set "@" + name.to_s.downcase, (content[name] == "N/A" ? "" : content[name])
      end
      
      @year    = @year.to_i
      @genres  = @genre.split(", ")
      @writers = @writer.split(", ")
      @actors  = @actors.split(", ")
      @rating  = @rating.to_f
      @votes   = @votes.to_i
      
      if @runtime =~ /(\d+).+?(\d+)/
        @runtime = $1.to_i * 60 + $2.to_i
      elsif @runtime =~ /(\d+) hrs/
        @runtime = $1.to_i * 60
      else
        @runtime = 0
      end 
    end
  end
  
  def found?
    content["Response"] == "True"
  end

  def released
    Date.parse(@released)
  rescue
    return nil
  end
  
  def tomato
    unless @params[:tomatoes]
      raise ArgumentError.new("You have to set 'tomatoes' to true to get this data.")
    end
    
    @_tomato ||= Struct.new(
      :meter, 
      :image,
      :rating,
      :reviews,
      :fresh,
      :rotten
    ).new(
      @tomatometer.to_i, 
      @tomatoimage,
      @tomatorating.to_f,
      @tomatoreviews.to_i,
      @tomatofresh.to_i,
      @tomatorotten.to_i
    )
  end
  
  def href
    "http://www.imdb.com/title/#{@id}/"
  end
  
  private
    def content
      @_content ||= JSON.parse(download)
    end

    def download
      @_download ||= RestClient.get(@url, timeout: 3)
    end
end