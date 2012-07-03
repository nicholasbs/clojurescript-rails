require 'rails'
require 'tilt'
require 'nailgun'

module ClojurescriptRails
  class ClojurescriptTemplate < ::Tilt::Template
    def initialize_engine
      @compiler ||= ClojurescriptCompiler.new
    end

    def prepare
    end

    def evaluate(scope, locals = {}, &block)
      # cmd = "#{CLJS_COMPILER} #{@file} '{:optimizations :advanced}'"
      # @output = `#{cmd}`
      @output ||= @compiler.compile @file
    end
  end

  class ClojurescriptCompiler
    CLOJURESCRIPT_HOME = File.dirname(__FILE__) + "/../../clojurescript/"
    COMPILER = "#{CLOJURESCRIPT_HOME}bin/cljsc.clj"

    def self.prepare_ng
      @@ng = Nailgun::NgCommand
      @@ng_path = Nailgun::NgCommand::NGPATH

      @@ng.start_server

      %w{src/clj src/cljs lib/clojure.jar lib/compiler.jar lib/goog.jar lib/js.jar}.each do |f|
        @@ng.ng_cp "#{CLOJURESCRIPT_HOME}#{f}"
      end
    end

    def compile(file)
      `#{@@ng_path} clojure.main #{COMPILER} #{file} "{:optimizations :advanced}"`
    end
  end
end
