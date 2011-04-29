# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "movies/version"

Gem::Specification.new do |s|
  s.name        = "movies"
  s.version     = Movies::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Linus Oleander"]
  s.email       = ["linus@oleander.nu"]
  s.homepage    = "https://github.com/oleander/Movies"
  s.summary     = %q{Unofficial API for IMDb.com}
  s.description = %q{Unofficial API for IMDb.com.}

  s.rubyforge_project = "movies"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  
  s.add_dependency("rest-client")
  s.add_dependency("nokogiri")
  
  s.add_development_dependency("vcr")
  s.add_development_dependency("rspec")  
  s.add_development_dependency("webmock")
  
  s.required_ruby_version = "~> 1.9.0"
end
