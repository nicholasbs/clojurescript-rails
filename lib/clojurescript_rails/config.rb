module ClojurescriptRails

  class Config

    class << self
      attr_reader :opts, :valid_opts
    end

    # Valid clojurescript compiler config options
    @valid_opts = {
      :optimizations => [:simple, :whitespace, :advanced],
      :pretty_print => [true, false]
    }

    # Default configuration options
    @opts = { :optimizations => :advanced }

    ##
    # opts setter
    #
    # Raises an ArgumentError unless configuration options and values are
    # present in Config.valid_opts

    def self.opts=(opts)
      invalid = opts.reject do |k, v|
        @valid_opts.has_key?(k) and @valid_opts[k].include?(v)
      end

      unless invalid.empty?
        msg = "Invalid ClojureScript Compiler options:"
        invalid.each { |k, v| msg += "\n  #{k.inspect} => #{v.inspect}" }
        raise ArgumentError.new(msg)
      end

      @opts = opts
    end

    def self.to_s
      opts_string
    end

  private

    ##
    # Returns the clojure map string representation of @opts

    def self.opts_string
      kvs = opts_to_clj().reduce("") { |s, kv| "#{s} #{kv[0]} #{kv[1]}" }
      "\"{#{kvs} }\""
    end

    ##
    # Returns a Hash with keys and values converted to strings represented
    # as clojure literals

    def self.opts_to_clj
      @opts.reduce({}) do |coll, kv|
        k, v = kv.map { |x| item_to_clj x }
        coll.merge k => v
      end
    end

    def self.item_to_clj(item)
      item.inspect.gsub /_/, "-"
    end
  end

end
