require "json"
require "rest-client"
require "date"

class Movies
  attr_reader :title, :year, :rated, :released, :plot, :genres, :director, :writers, :actors, :poster, :runtime, :rating, :votes, :id
  def initialize(url, params = {})
    @url = "#{url}&#{params.map{|key, value| "#{key}=#{value}"}.join("&")}"
  end

  def self.find_by_id(id, params = {})
    unless id.to_s.match(/tt\d{4,}/)
      raise ArgumentError.new("The id is not valid")
    end
    Movies.new("http://www.imdbapi.com/?i=#{id}", params).prepare
  end
  
  def self.find_by_title(title, params = {})
    if title.nil? or title.empty?
      raise ArgumentError.new("Title can not be blank")
    end
    Movies.new("http://www.imdbapi.com/?t=#{URI.encode(title)}", params).prepare
  end
  
  
  def prepare
    tap do
      content.keys.each do |name| 
        instance_variable_set "@" + name.to_s.downcase, content[name] 
      end
      
      @year     = @year.to_i
      @released = Date.parse(@released)
      @genres   = @genre.split(",")
      @writers  = @writer.split(",")
      @actors   = @actors.split(", ")
      @rating   = @rating.to_f
      @votes    = @votes.to_i
      
      if @runtime =~ /(\d+).+?(\d+)/
        @runtime = $1.to_i * 60 + $1.to_i
      elsif @runtime =~ /(\d+) hrs/
        @runtime = $1.to_i * 60
      else
        @runtime = 0
      end 
    end
  end
  
  def href
    "http://www.imdb.com/title/#{@id}/"
  end
  
  private
    def content
      @_content ||= JSON.parse(download)
    end

    def download
      @_download ||= RestClient.get(@url, timeout: 10)
    end
end