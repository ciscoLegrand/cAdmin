module Cadmin
  class WebhooksController < ApplicationController
    skip_before_action :authenticate_user!
    skip_before_action :verify_authenticity_token

    def create
      payload = request.body.read
      sig_header = request.env['HTTP_STRIPE_SIGNATURE']
      event = nil

      begin
        event = Stripe::Webhook.construct_event(
          payload, sig_header, ENV['STRIPE_WEBHOOK_SECRET']
        )
      rescue JSON::ParserError => e
        status 400
        return
      rescue Stripe::SignatureVerificationError => e
        # Invalid signature
        puts "Signature error"
        p e
        return
      end

      # Handle the event
      case event.type
      when 'checkout.session.completed'
        
        # TODO: LOOK AT STRIPE DASHBOARD EVENTS AND FIND OUT HOW TO GET THE EVENT ID
        session = event.data.object
        p session

      end

      render json: { message: 'success' }
    end
  end
end