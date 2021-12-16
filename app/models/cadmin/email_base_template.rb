module Cadmin
  class EmailBaseTemplate < ApplicationRecord
    has_many :email_custom_templates, dependent: :destroy

    validates :kind, presence: true, uniqueness: true
    validates_presence_of :title, :content

    enum kind: { 
      welcome: 0,
      reset_password: 1,
      new_event: 2,
      update_event: 3,
      event_has_employee: 4,
      billing_is_ready: 5
     }

    def self.pending?
      self.kinds.keys.all? { |kind| self.pluck(:kind).include?(kind) }
    end

    def has_custom_template?
      template = self.email_custom_templates
      template.any? ? template.present? : false
      # any? -> returns collections
    end
  
    def custom_template
      self.email_custom_templates.first
    end
  end
end
