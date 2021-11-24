module Cadmin  
  module DateFormat 
    extend ActiveSupport::Concern 
    
    def user_created_date_format
      self.created_at.strftime("%d-%m-%y") if self.created_at.present?
    end

    def user_invitation_date_format
      self.invitation_sent_at.strftime("%d-%m-%y [%H:%M]") if self.invitation_sent_at.present?
    end

    def last_sign_in_format
      self.last_sign_in_at.strftime("%d-%m-%y [%H:%M]") if self.last_sign_in_at.present?
    end

    def created_format 
      self.created_at.strftime('%d-%m-%Y [%H:%M]') if self.created_at.present?
    end
    def updated_format 
      self.updated_at.strftime('%d-%m-%Y [%H:%M]') if self.updated_at.present?
    end
  end
end