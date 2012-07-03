require 'rails'
require 'tilt'

module ClojurescriptRails
  class ClojurescriptTemplate < ::Tilt::Template
    #def self.engine_initialized?
    #  true
    #end

    #def initialize_engine
    #end

    def prepare
    end

    def evaluate(scope, locals = {}, &block)
      cmd = "#{CLJS_COMPILER} #{@file} '{:optimizations :advanced}'"
      @output = `#{cmd}`
    end
  end
end
