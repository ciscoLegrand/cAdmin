module Cadmin
  class Event < ApplicationRecord
    belongs_to :customer, foreign_key: :customer_id, class_name: 'User'
    belongs_to :employee, optional: true, foreign_key: :employee_id, class_name: 'User'
    has_one :interview
    
    validates :number, presence: true, uniqueness: true
    serialize :service_ids, Array
    serialize :discount_ids, Array

    delegate :name, :last_name, :avatar, :email, :phone, :address, :birthdate, :city, :province, :postal_code, :shipping_address, :billing_address, to: :customer, prefix: :customer
    delegate :name, :phone, :avatar, to: :employee, prefix: :employee
    delegate :name, to: :location, prefix: :location

    PERMITED_EVENT = [
      'Boda', 'Cena', 'Comunion', 'Despedida','Cumpleaños', 'Bodas de plata/oro'
    ]

    def servicename 
      names=[]
      self.service_ids.each do |ser| 
       names << Service.find(ser).name if ser.present?
      end
      names.split(',').join(', ')
    end

    def discountnames
      names=[]
      self.discount_ids.each do |dis| 
       names << Discount.find(dis).name if dis.present?
      end
      names.split(',').join(', ')
    end

    def total_services_amount   
      total = 0  
      ids = [] 
      self.service_ids.each do |ser| 
        unless ser == ""
          ids << ser.to_i
        end
      end
      ids.each do |id|
        service = Service.find(id)
        if self.extra_hours.present? 
          t_hours = service.hour_price * self.extra_hours
        end
        total += service.price + t_hours
      end
      total
    end 

    def placename 
      Location.find_by_id( self.place_id).name if self.place_id.present? 
    end

    scope :sort_by_date, -> { order('date ASC') }
    # ! SEARCH BETWEEN DATES 
    scope :filter_between_dates, -> (start_date, end_date) { where(date: start_date..end_date) }
    scope :filter_by_user_id, -> (user_id) { where(customer_id: user_id)}
    
    # ! pgsearch busqueda por campos de texto
    scope :filter_by_number, -> (number) { where("number like ?", "%#{number}%") }
    # pg_search_scope :filter_by_name, against: :name
  end
end
