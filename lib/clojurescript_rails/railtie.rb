module ClojurescriptRails
  class Engine < ::Rails::Engine
    initializer :clojurescript_rails do |app|
      app.assets.register_engine '.cljs', ClojurescriptTemplate
    end
  end
end
