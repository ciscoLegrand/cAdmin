module Cadmin
  class CheckoutController < ApplicationController 
    def create
      @product = Event.find(params[:id])
      @session = Stripe::Checkout::Session.create({
        customer: current_cadmin_user.stripe_customer_id,
        payment_method_types: [
          "card"
        ],
        line_items: [{
          name: @product.servicenames,
          amount: (@product.deposit*100).to_i,
          currency: "eur",
          quantity: 1
        }],
        mode: 'payment',
        success_url: success_url + "?session_id={CHECKOUT_SESSION_ID}"  ,
        cancel_url: cancel_url ,
      })
      # STRIPE documentation to checkout payment process -> https://github.com/stripe-samples/checkout-one-time-payments/blob/master/server/ruby/server.rb#L70-L82 
      redirect_to @session.url
    end

    def success 
      if params[:session_id].present?
        @cart.booked!
        Event.find_by(cart_id:@cart.id).book!
        
        @session_with_expand = Stripe::Checkout::Session.retrieve({ id: params[:session_id], expand: ["line_items"]})        
        session[:cart_id] = nil
        @cart = Cart.create!(ip: request.remote_ip)
        session[:cart_id] = @cart.id
      else
        redirect_to cancel_url, alert: "Payment was not successful"
      end
    end

    def cancel 
    end
  end
end