module Cadmin
  class EventMailer < ApplicationMailer

    def admin_event(event)
      @event = event 
      @user = User.find(@event.customer_id) 
      # raise @correo.to_json
      @greeting = "#{@user.name} ha hecho una reserva de servicios"
      # =>  destinatario del correo  , quien envia el correo
      mail( to: 'cisco.glez@gmail.com' ,from:  @user.email , subject: @greeting)
    end
  end
end
