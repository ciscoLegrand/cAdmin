module Cadmin
  class EventMailer < ApplicationMailer
    # layout 'cadmin/mailer'
    def admin_event(event)
      @event = event 
      @user = User.find(@event.customer_id) 
      # raise @correo.to_json
      @greeting = "#{@user.name} ha hecho una nueva reserva"
      # =>  destinatario del correo  , quien envia el correo
      mail( to:  ENV['GMAIL_ACCOUNT'] , from: ENV['GMAIL_ACCOUNT'] , subject: @greeting)
    end

    def customer_event(event)
      @event = event 
      @user = User.find(@event.customer_id) 
      # raise @correo.to_json
      @greeting = "Gracias por realizar la reserva, en breve nos pondremos en contacto contigo"
      # =>  destinatario del correo  , quien envia el correo
      mail( to: @user.email ,from:   ENV['GMAIL_ACCOUNT'] , subject: @greeting)
    end

    def confirmation_event(event)
      @event = event 
      @user = User.find(@event.customer_id) 
      # raise @correo.to_json
      @greeting = "Hola #{@user.name}, gracias por confiar en La Gramola disco, hemos confirmado tu reserva."
      # =>  destinatario del correo  , quien envia el correo
      mail( to: @user.email ,from: ENV['GMAIL_ACCOUNT'] , subject: @greeting)
    end
  end
end
