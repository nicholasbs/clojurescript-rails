require 'rails'
require 'tilt'
require 'nailgun'

module ClojurescriptRails
  class ClojurescriptTemplate < ::Tilt::Template
    def initialize_engine
    end

    def prepare
      @compiler ||= ClojurescriptCompiler.new
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
      `#{@@ng_path} clojure.main #{COMPILER} #{file} #{CompilerConfig.config_string}`
    end
  end

  class CompilerConfig

    class << self
      attr_reader :config, :opts
    end

    # Valid clojurescript compiler config options
    @opts = {
      :optimizations => [:simple, :whitespace, :advanced],
      :pretty_print => [true, false]
    }

    # Default configuration
    @config = { :optimizations => :advanced }

    ##
    # config setter
    #
    # Raises an ArgumentError unless configuration options and values are
    # present in CompilerConfig.opts

    def self.config=(config)
      invalid = config.reject do |k, v|
        @opts.has_key?(k) and @opts[k].include?(v)
      end

      unless invalid.empty?
        msg = "Invalid ClojureScript Compiler options:"
        invalid.each { |k, v| msg += "\n  #{k.inspect} => #{v.inspect}" }
        raise ArgumentError.new(msg)
      end

      @config = config
    end

    ##
    # Returns the clojure map string representation of @config

    def self.config_string
      kvs = config_to_clj().reduce("") { |s, kv| "#{s} #{kv[0]} #{kv[1]}" }
      "\"{#{kvs} }\""
    end

    ##
    # Returns a Hash with keys and values converted to strings represented
    # as clojure literals

    def self.config_to_clj
      @config.reduce({}) do |coll, kv|
        k, v = kv.map { |x| item_to_clj x }
        coll.merge k => v
      end
    end

  private
    def self.item_to_clj(item)
      item.inspect.gsub /_/, "-"
    end
  end
end
