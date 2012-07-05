module ClojurescriptRails

  class Config

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
    # present in Config.opts

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
