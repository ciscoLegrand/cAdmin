module Cadmin
  class Engine < ::Rails::Engine
    isolate_namespace Cadmin

  #   config.to_prepare do
  #     Devise::SessionsController.layout "application"
  #   end
    config.autoload_paths = %w(#{Cadmin::Engine.root}/app/models/concerns/cadmin)

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

    #! https://stackoverflow.com/questions/18538549/cant-get-rack-cors-working-in-rails-application -> permit cors configuration
    config.middleware.use Rack::Cors do
      allow do
        origins '*'
        resource '*', headers: :any, methods: [:get, :post, :delete, :put, :options]
      end
    end
    
    #! https://github.com/rails/rails/blob/main/railties/lib/rails/engine.rb -> engine custom configurations
    def app
      @app || @app_build_lock.synchronize {
        @app ||= begin
          stack = default_middleware_stack
          config.middleware = build_middleware.merge_into(stack)
          config.middleware.build(endpoint)
        end
      }
    end
  end
end
