module Cadmin
  class Engine < ::Rails::Engine
    isolate_namespace Cadmin

    config.generators do |g|
      g.orm             :active_record
      g.template_engine :erb
      g.test_framework  false
      g.stylesheets     false
      g.helper          false
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
