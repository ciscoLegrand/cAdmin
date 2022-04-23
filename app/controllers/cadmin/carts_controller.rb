require_dependency "cadmin/application_controller"

module Cadmin
  class CartsController < ApplicationController 
    skip_before_action :authenticate_cadmin_user!, :only => [:index]
    before_action :set_cart
    def index
      @total_cart_amount = @cart.total_cart_amount
      @main_service = MainService.first
    end
  
    private 
      def set_cart 
        @cart = Cart.find(session[:cart_id])
      end
  end
end