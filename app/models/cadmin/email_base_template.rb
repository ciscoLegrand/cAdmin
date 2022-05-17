module Cadmin
  class EmailBaseTemplate < ApplicationRecord
    extend FriendlyId

    friendly_id :title, use: :slugged
    
    has_many :email_custom_templates, dependent: :destroy

    validates :kind, presence: true, uniqueness: true
    validates_presence_of :title, :content

    enum kind: { 
      welcome: 0,
      reset_password: 1,
      new_event: 2,
      new_event_admin: 3,
      customer_update_event: 4,
      employee_update_event: 5,
      billing_is_ready: 6
     }

    def self.pending?
      self.kinds.keys.all? { |kind| self.pluck(:kind).include?(kind) }
    end

    def has_custom_template?
      template = self.email_custom_templates
      template.any? ? template.present? : false
    end
  
    def custom_template
      self.email_custom_templates.first
    end
  end
end
