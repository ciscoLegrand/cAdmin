module Cadmin
  class CheckoutController < ApplicationController 
    def create
      product = Event.find(params[:id])      

      @session = Stripe::Checkout::Session.create({
        payment_method_types: [
          "card"
        ],
        line_items: [{
          name: product.servicenames,
          amount: (product.deposit*100).to_i,
          currency: "eur",
          quantity: 1
        }],
        mode: 'payment',
        success_url: root_url  ,
        cancel_url: main_app.root_url ,
      })
      # STRIPE documentation to checkout payment process -> https://github.com/stripe-samples/checkout-one-time-payments/blob/master/server/ruby/server.rb#L70-L82 
      redirect_to @session.url
      restart_new_session_cart
      product.update!(charged: true)
      # product.book!
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