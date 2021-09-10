module Cadmin
  class ApplicationController < ActionController::Base
    add_flash_types :success, :info, :error, :alert
    protect_from_forgery with: :exception

    before_action :authenticate_cadmin_user!
    before_action :configure_permitted_parameters, if: :devise_controller?
    before_action :set_breadcrumbs
    before_action :set_web_module
    protected
   
    def configure_permitted_parameters
      added_attrs = [:name, :username, :email,:phone, :password, :password_confirmation, :remember_me]
      devise_parameter_sanitizer.permit :sign_in, keys: [:email, :password]
      devise_parameter_sanitizer.permit :register, keys: added_attrs
      devise_parameter_sanitizer.permit :account_update, keys: added_attrs
    end
    
    def set_breadcrumbs
      add_breadcrumb 'Inicio', root_path
    end

    def after_sign_in_path_for(resource)
      root_path
    end

    def set_web_module
      @web_module = WebModule.first
    end
  end
end
