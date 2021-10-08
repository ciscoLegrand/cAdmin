module Cadmin
  class Event < ApplicationRecord
    belongs_to :user
    validates :number, presence: true, uniqueness: true
    serialize :service_ids, Array

    delegate :name, to: :user, prefix: :user

    def servicename 
      names=[]
      self.service_ids.each do |ser| 
       names << Service.find_by_id(ser).name if ser.present?
      end
      names.split(',').join(' ')
    end


    def placename 
      Location.find_by_id( self.place_id).name if self.place_id.present? 
    end

    scope :sort_by_date, -> { order('date ASC') }

  end
end
