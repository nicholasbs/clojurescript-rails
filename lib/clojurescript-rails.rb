require 'ruby-debug'
module ClojurescriptRails
  require 'rails'
  require 'tilt'

  class ClojureScriptTemplate < ::Tilt::Template
    #def self.engine_initialized?
    #  true
    #end

    #def initialize_engine
    #end

    def prepare
    end

    def evaluate(scope, locals = {}, &block)
      @output = "FOO!!!"
    end
  end

  class Engine < ::Rails::Engine
    initializer 'sprockets.clojurescript', :group => :all, :after => 'sprockets.environment' do |app|
      app.assets.register_engine '.cljs', ClojureScriptTemplate
    end
  end
end
