module Cadmin
  class CheckoutController < ApplicationController 
    def create
      product = Service.find(params[:id])   
      @session = Stripe::Checkout::Session.create({
        payment_method_types: ['card'],
        line_items: [{
          name: product.name,
          amount: (product.price * 100).to_i,
          currency: 'eur',
          quantity: 1,
        }],
        mode: 'payment',
        success_url: root_url,
        cancel_url: root_url,
      })
      respond_to do |format|
        format.js 
      end
    end
  end
end