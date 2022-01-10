require_dependency "cadmin/application_controller"

module Cadmin
  class CartItemsController < ApplicationController 
    def create     
      @cart_item = CartItem.new(service_id: params[:service_id], cart: @cart)
      @cart_item.set_cart_data(@cart.id, params[:service_id])

      main  = @cart_item.service.main_service
      service = @cart_item.service

      if @cart_item.save
        @count = Cart.find(session[:cart_id]).cart_items.count
        # # render json: {cart: count, reponse: "ok", notice: "Service #{Service.find(params[:service_id]).name} was successfully added to cart."}
        redirect_to main_app.servicio_path(main, service) , success: "#{service.name} was successfully added to cart." #TODO: thinking about redirect to cart_path or main_app.servicio_path¿?
      else   
        render json: @cart_item.errors, status: 400
      end
    end
    
    def destroy
      @cart_item = CartItem.find(params[:id])
      service = @cart_item.service
      @cart_item.destroy
      count = Cart.find(session[:cart_id]).cart_items.count
      redirect_to cart_path, alert: "#{service.name} was successfully removed from cart."
      # render json: {cart: count, reponse: "ok"}
    end

    private

  end
end