module Cadmin
  class CheckoutController < ApplicationController 
    def create
      product = Service.find(params[:id])
      category = product.main_service_id 

      @session = Stripe::Checkout::Session.create({
        payment_method_types: [
          "card"
        ],
        line_items: [{
          name: product.name,
          amount: (product.price*100).to_i,
          currency: "eur",
          quantity: 1
        }],
        mode: 'payment',
        success_url: root_url  ,
        cancel_url: root_url ,
      })
      # STRIPE documentation to checkout payment process -> https://github.com/stripe-samples/checkout-one-time-payments/blob/master/server/ruby/server.rb#L70-L82
      redirect_to @session.url
    end
  end
end