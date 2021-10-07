module Cadmin
  class Event < ApplicationRecord
    belongs_to :user
    validates :number, presence: true, uniqueness: true
    serialize :service_ids, Array

    delegate :name, to: :user, prefix: :user

    def servicename 
      Service.find_by_id( self.service_id).name 
    end

    def placename 
      Location.find_by_id( self.place_id).name if self.place_id.present? 
    end

    scope :sort_by_date, -> { order('date ASC') }

  end
end
