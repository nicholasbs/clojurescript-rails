$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "clojurescript-rails/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "clojurescript-rails"
  s.version     = ClojureScriptRails::VERSION
  s.authors     = ["Zach Allaun", "Nicholas Bergson-Shilcock"]
  s.email       = ["zachallaun@gmail.com"]
  s.homepage    = "http://github.com/nicholasbs/clojurescript-rails"
  s.summary     = "A plugin for using ClojureScript with the Rails asset pipeline."
  s.description = ""

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 3.2.6"
end
