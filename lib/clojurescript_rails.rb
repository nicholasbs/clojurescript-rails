require 'ruby-debug'
require 'rails'
require 'tilt'
require 'nailgun'
require 'clojurescript_rails/config'
require 'clojurescript_rails/template'
require 'clojurescript_rails/railtie'
require 'clojurescript_rails/compiler'

ClojurescriptRails::Compiler.prepare_ng
