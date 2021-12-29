require_relative "lib/cadmin/version"

Gem::Specification.new do |spec|
  spec.name        = "cadmin"
  spec.version     = Cadmin::VERSION
  spec.authors     = ["ciscoLegrand"]
  spec.email       = ["cisco.glez@gmail.com"]
  spec.homepage    = "http://www.cappweb.ga"
  spec.summary     = "Admin app engine"
  spec.description = "Admin app engine"
  spec.license     = "MIT"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/ciscoLegrand/cAdmin.git"
  
  spec.files = Dir["{app,config,db,lib,spec}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  # here we add the gems that we will use and then we will need to require them in lib/cadmin.rb
  spec.add_dependency "rails", "~> 6.1.4", ">= 6.1.4.1"
  # db
  spec.add_dependency 'pg'
  spec.add_dependency 'pg_search'
  spec.add_dependency 'active_model_serializers'
  
  # users
  spec.add_dependency 'devise'
  spec.add_dependency 'devise_invitable'
  
  # styles and js
  spec.add_dependency "bulma-rails"
  spec.add_dependency "turbo-rails"
  spec.add_dependency "stimulus-rails", '~> 0.2.4'
  
  # helpers behaviour 
  spec.add_dependency 'view_component'
  spec.add_dependency "breadcrumbs_on_rails"
  spec.add_dependency 'inline_svg'
  spec.add_dependency 'pagy'
  
  # images
  spec.add_dependency "image_processing", "~> 1.8"
  spec.add_dependency 'shrine'
  
  # spotify   
  spec.add_dependency 'rspotify'

  spec.add_dependency 'liquid'

  spec.add_dependency 'friendly_id'
  
  # dev dependencies
  spec.add_development_dependency "rspec-rails"
  spec.add_development_dependency "letter_opener"
end