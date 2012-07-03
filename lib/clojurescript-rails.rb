require 'ruby-debug'
require 'clojurescript_rails/template'

module ClojurescriptRails
  CLJS_COMPILER = File.dirname(__FILE__) + "/../clojurescript/bin/cljsc"

  class Engine < ::Rails::Engine
    initializer :clojurescript_rails do |app|
      app.assets.register_engine '.cljs', ClojurescriptTemplate
    end
  end
end
