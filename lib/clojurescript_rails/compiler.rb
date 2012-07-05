module ClojurescriptRails
  class Compiler
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
      `#{@@ng_path} clojure.main #{COMPILER} #{file} #{Config}`
    end
  end
end
