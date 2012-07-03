require 'ruby-debug'
require 'clojurescript_rails/template'

module ClojurescriptRails
  ClojurescriptCompiler.prepare_ng

  class Engine < ::Rails::Engine
    initializer :clojurescript_rails do |app|
      app.assets.register_engine '.cljs', ClojurescriptTemplate
    end
  end
end
