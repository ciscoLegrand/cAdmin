module Cadmin
  class CheckoutController < ApplicationController 
    def create
      product = Service.friendly.find(params[:id])
      category = product.main_service_id 

      card = Stripe::PaymentMethod.create({
        type: 'card',
        card: {
          number: '4242424242424242',
          exp_month: 1,
          exp_year: 2023,
          cvc: '314',
        },
      })


      @session = Stripe::Checkout::Session.create({
        line_items: [{
          name: product.name,
          amount: (product.price*100).to_i,
          currency: "eur",
          quantity: 1
        }],
        payment_method_types: [
          "card"
        ],
        mode: 'payment',
        success_url: main_app.root_url  ,
        cancel_url: main_app.root_url ,
      })
      respond_to do |format|
        format.js
      end
    end
  end
end