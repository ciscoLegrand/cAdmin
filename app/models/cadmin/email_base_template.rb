module Cadmin
  class EmailBaseTemplate < ApplicationRecord
    validates :kind, presence: true, uniqueness: true
    validates_presence_of :title, :content

    enum kind: { 
      welcome: 0,
      reset_password: 1,
      new_event: 2,
      update_event: 3,
      event_has_employee: 4
     }

    def self.pending?
      self.kinds.keys.all? { |kind| self.pluck(:kind).include?(kind) }
    end
  end
end
