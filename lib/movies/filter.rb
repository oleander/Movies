class MovieFilter
  def initialize(args)
    args.keys.each { |name| instance_variable_set "@" + name.to_s, args[name] }
  end
  
  def year
    @year ||= @title.to_s.match(/((19|20)\d{2})/).to_a[1]
    @year.to_i if @year
  end
  
  def title
    @_title ||= cleaner
  end
  
  def to_param 
    params = {}
    if year
      params.merge!(y: year.to_i)
    end
    
    return params
  end
  
  def cleaner
    string = @title
    string = extract_tags(string)
    [/((19|20)\d{2}).*$/, /\./, /\s*-\s*/, /\s{2,}/].each do |regex|
      string = string.gsub(regex, ' ')
    end
    
    excluded["plain"].each { |clean| string.gsub!(/#{clean}.*$/i, ' ') }
    excluded["groups"].each { |clean| string.gsub!(/#{clean}.*$/, ' ') }
    
    string.strip
  end
  
  # remove usual tags in filenames like {720p}, (2011) or [KingdomRelease], and save it 
  def extract_tags(string)
    @tags = []
    [ /\[([^\[]*)\]/ , /\{([^\{]*)\}/ , /\(([^\(]*)\)/ ].each do |regex|
      while(matched = string.match(regex)) do
        @tags << matched[1]
        string.gsub!(matched[0])
      end
    end
  end
  
  private
    def excluded
      @_excluded ||= YAML.load_file("#{File.dirname(__FILE__)}/exclude.yml")["excluded"]
    end
end