require "cadmin/version"
require "cadmin/engine"
require "cadmin/cadmin_importmap_helper"

# here we place the gems that we add in the ../cadmin.gemspec
require 'pg'
require 'pg_search'
require 'bulma-rails'
require 'turbo-rails'  
require 'stimulus-rails'
require 'inline_svg'
require "breadcrumbs_on_rails"
require "view_component"
require "devise"
require "devise_invitable"
require 'shrine'
require "image_processing"
require "pagy"
  
  require "rspotify"
  require "active_model_serializers"
module Cadmin
  class Engine < ::Rails::Engine

    isolate_namespace Cadmin

  end
end
