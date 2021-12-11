module Cadmin
  class Engine < ::Rails::Engine
    isolate_namespace Cadmin

    config.autoload_paths = %w(#{Cadmin::Engine.root}/app/models/concerns/cadmin)
    
    config.generators do |g|
      g.orm             :active_record
      g.template_engine :erb
      g.test_framework  :rspec
      g.stylesheets     false
      g.helper          false
    end

    #! configuration to avoid installing migrations in the main application
    initializer :append_migrations do |app|
      unless app.root.to_s.match root.to_s+File::SEPARATOR
        app.config.paths["db/migrate"].concat(
            config.paths["db/migrate"].expanded)
      end
    end
    
    initializer "cadmin.assets.precompile" do |app|
      app.config.assets.precompile += %w(cadmin_manifest cadmin/importmap.json)
    end
    
    initializer "cadmin.helpers" do
      Rails.application.config.assets.configure do |env|
        env.context_class.class_eval { include CadminImportmapHelper }
      end
    end
  end
end
