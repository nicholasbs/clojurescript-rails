require 'ruby-debug'
require 'clojurescript-rails/template'

module ClojureScriptRails
  CLJS_COMPILER = File.dirname(__FILE__) + "/../clojurescript/bin/cljsc"

  class Engine < ::Rails::Engine
    initializer 'clojurescript-rails' do |app|
      app.assets.register_engine '.cljs', ClojureScriptTemplate
    end
  end
end
