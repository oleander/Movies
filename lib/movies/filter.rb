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
    [/((19|20)\d{2}).*$/, /\./, /\s*-\s*/, /\s{2,}/].each do |regex|
      string = string.gsub(regex, ' ')
    end
    
    excluded.each do |clean|
      string = string.gsub(/#{clean}.*$/i, ' ')
    end
    
    string.strip
  end
  
  private
    def excluded
      @_excluded ||= YAML.load_file("#{File.dirname(__FILE__)}/exclude.yml")["excluded"]
    end
end