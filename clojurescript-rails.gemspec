$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "clojurescript_rails/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "clojurescript_rails"
  s.version     = ClojurescriptRails::VERSION
  s.authors     = ["Zach Allaun", "Nicholas Bergson-Shilcock"]
  s.email       = ["zachallaun@gmail.com"]
  s.homepage    = "http://github.com/nicholasbs/clojurescript_rails"
  s.summary     = "A plugin for using ClojureScript with the Rails asset pipeline."
  s.description = ""

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 3.2.6"
  # TODO: Add dependency on nailgun once necessary changes are pushed upstream
  # s.add_dependency "nailgun", "0.0.2"
end
