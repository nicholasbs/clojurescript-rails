module ClojurescriptRails

  class ClojurescriptTemplate < ::Tilt::Template
    def initialize_engine
    end

    def prepare
      @compiler ||= Compiler.new
    end

    def evaluate(scope, locals = {}, &block)
      # cmd = "#{CLJS_COMPILER} #{@file} '{:optimizations :advanced}'"
      # @output = `#{cmd}`
      @output ||= @compiler.compile @file
    end
  end

end
