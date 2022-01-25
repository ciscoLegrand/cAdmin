module Cadmin
  class ApplicationController < ActionController::Base
    include Pagy::Backend

    add_flash_types :success, :info, :error, :alert, :notice
    protect_from_forgery with: :exception

    before_action :authenticate_cadmin_user!
    before_action :configure_permitted_parameters, if: :devise_controller?
    before_action :set_breadcrumbs
    before_action :set_web_module
    before_action :set_main_services
    before_action :set_unviewed_messages 
    before_action :set_events
    before_action :set_cart
    # before_action :run_update_status_event_job
    

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
      
      def set_events
        @events = Event.all
      end 

      def set_cart
        @cart = Cart.find(session[:cart_id]) if session[:cart_id].present?
      end

      def set_unviewed_messages 
        @unviewed_messages = 0
        if current_cadmin_user.present?
          @conversations = Conversation.where(recipient_id: current_cadmin_user.id) 
          @conversations.each do |conversation|
            @unviewed_messages += conversation.messages.where(viewed: false).count
          end
        end
        @unviewed_messages
      end

      def set_breadcrumbs
        add_breadcrumb 'Inicio', root_path
      end

      def after_sign_up_path_for(resource)
        root_path
      end
      
      def after_sign_in_path_for(resource)
        root_path
      end

      def set_web_module
        @web_module = WebModule.first
      end

      def run_update_status_event_job
        UpdateStatusEventJob.set(wait: 1.day).perform_later(@events)
      end
  end
end
