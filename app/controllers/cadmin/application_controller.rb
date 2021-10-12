module Cadmin
  class ApplicationController < ActionController::Base
    include Pagy::Backend

    add_flash_types :success, :info, :error, :alert
    protect_from_forgery with: :exception

    before_action :authenticate_cadmin_user!
    before_action :configure_permitted_parameters, if: :devise_controller?
    before_action :set_breadcrumbs
    before_action :set_web_module
    before_action :set_main_services
    protected
   
    def configure_permitted_parameters
      added_attrs = [:name, :last_name, :username, :email,:phone, :password, :password_confirmation, :remember_me, :avatar, :address, :city, :province, :postal_code, :shipping_address, :billing_address]
      devise_parameter_sanitizer.permit :sign_in, keys: [:email, :password]
      devise_parameter_sanitizer.permit :register, keys: added_attrs
      devise_parameter_sanitizer.permit :account_update, keys: added_attrs
      devise_parameter_sanitizer.permit :accept_invitation, keys: added_attrs
    end
    
    def set_main_services
      @main_services =  MainService.all 
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
