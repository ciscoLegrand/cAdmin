module Cadmin
  class UserMailer < ApplicationMailer
    def welcome(resource)
      template_email(0)
      @user = resource 
      # raise @correo.to_json
      @greeting = "Bienvenido #{@user.name}, te has registrado correctamente en #{ENV['DOMAINWWW']}"
      # =>  destinatario del correo  , quien envia el correo
      mail( to:  @user.email , from: "La gramola disco <#{ENV['GMAIL_ACCOUNT']}>" , subject: @greeting)
    end

    def reset_password(resource, token)
      template_email(1)
      @user = resource 
      @password = token 
      @user.update!(password: token)
      
      @greeting = "#{@user.name} se ha cambiado la contraseña, por #{@password}"
      mail( to:  @user.email , from: "La gramola disco <#{ENV['GMAIL_ACCOUNT']}>" , subject: @greeting)
    end

    def invitation_instructions(resource, password)
      template_email(8)
      @user = resource 
      @password = password  
      @greeting = "Bienvenido #{@user.name}, activa tu cuenta"
      mail( to:  @user.email , from: "La gramola disco <#{ENV['GMAIL_ACCOUNT']}>" , subject: @greeting)
    end

    protected 
      def template_email(kind_id)
        email_base_template = Cadmin::EmailBaseTemplate.find_by(kind: kind_id)
        data = email_base_template.has_custom_template? ? email_base_template.custom_template : email_base_template
        @template = Liquid::Template.parse(data.content)   
      end
  end
end
