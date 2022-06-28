module Cadmin
  class CheckoutController < ApplicationController 
    def create
      @product = Event.find(params[:id])
      #! update role and create customer on stripe
      current_cadmin_user.create_stripe_customer unless current_cadmin_user.stripe_customer_id.present?
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
        success_url: main_app.success_url + "?session_id={CHECKOUT_SESSION_ID}"  ,
        cancel_url: main_app.cancel_url ,
      })
      # STRIPE documentation to checkout payment process -> https://github.com/stripe-samples/checkout-one-time-payments/blob/master/server/ruby/server.rb#L70-L82 
      redirect_to @session.url
    end

    def success 
      if params[:session_id].present?
        
        @cart.booked!
        @event = Event.find_by(cart_id:@cart.id)
        @event.book!

        begin
          @session_with_expand = Stripe::Checkout::Session.retrieve({ id: params[:session_id], expand: ["line_items"]})        
          EventMailer.admin_event(@event).deliver
          EventMailer.confirmation_event(@event).deliver
          session[:cart_id] = nil
          @cart = Cart.create!(ip: request.remote_ip)
          session[:cart_id] = @cart.id
        rescue => exception
          @event.event_services.each { |es| es.stock_increment! }
          @event.destroy      
          session[:cart_id] = nil
          @cart = Cart.create!(ip: request.remote_ip)
          session[:cart_id] = @cart.id  
          puts exception.message
          redirect_to main_app.cancel_url, error: "Payment was not successful -> #{exception.message}"
        end
      else
        redirect_to main_app.cancel_url, alert: "Payment was not successful"
      end
    end

    def cancel 
    end
  end
end