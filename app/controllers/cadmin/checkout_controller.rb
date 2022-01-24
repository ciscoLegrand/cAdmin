module Cadmin
  class CheckoutController < ApplicationController 
    def create
      product = Event.find(params[:id])      

      @session = Stripe::Checkout::Session.create({
        payment_method_types: [
          "card"
        ],
        line_items: [{
          name:  product.number,
          amount: (product.deposit*100).to_i,
          currency: "eur",
          quantity: 1
        }],
        mode: 'payment',
        success_url: root_url  ,
        cancel_url: root_url ,
      })
      # STRIPE documentation to checkout payment process -> https://github.com/stripe-samples/checkout-one-time-payments/blob/master/server/ruby/server.rb#L70-L82 
      restart_new_session_cart
      redirect_to @session.url
    end

    private
    
      def restart_new_session_cart 
        @cart.booked!
        session[:cart_id] = nil
        @cart = Cart.create!(ip: request.remote_ip)
        session[:cart_id] = @cart.id
      end
  end
end