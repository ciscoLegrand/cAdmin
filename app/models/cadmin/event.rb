module Cadmin
  class Event < ApplicationRecord
    belongs_to :customer, foreign_key: :customer_id, class_name: 'User'
    belongs_to :employee, foreign_key: :employee_id, class_name: 'User'
    
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
    # ! SEARCH BETWEEN DATES 
    scope :filter_between_dates, -> (start_date, end_date) { where(date: start_date..end_date) }
    scope :filter_by_user_id, -> (user_id) { where(user_id: user_id)}
    
    # ! pgsearch busqueda por campos de texto
    scope :filter_by_number, -> (number) { where(number: number)}
    # pg_search_scope :filter_by_name, against: :name
  end
end
