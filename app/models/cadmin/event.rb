module Cadmin
  class Event < ApplicationRecord
    extend FriendlyId

    friendly_id :title, use: :slugged

    include PgSearch::Model
    include Cadmin::DateFormat

    # state machine to change status of event    
    include AASM
    aasm.attribute_name :status
    aasm column: :status do
      state :pending, initial: true
      state :payed, :completed, :cancelled, :restarted

      event :pay do
        transitions from: [:pending, :completed], to: :payed
      end

      event :complete do
        transitions from: :pending, to: :completed
      end

      event :cancel do
        transitions from: :pending, to: :cancelled
      end
    end

    belongs_to :customer, foreign_key: :customer_id, class_name: 'User'
    belongs_to :employee, optional: true, foreign_key: :employee_id, class_name: 'User'
    has_one :interview, dependent: :destroy
    has_one :cart, dependent: :destroy
    has_many :event_services, dependent: :destroy
    accepts_nested_attributes_for :event_services,
                                  allow_destroy: true,
                                  reject_if: proc { |attr| attr['service_id'].blank? }

    validates :number, presence: true, uniqueness: true  

    delegate :name, :last_name, :avatar, :email, :phone, :address, :birthdate, :city, 
             :province, :postal_code, :shipping_address, :billing_address, 
             to: :customer, prefix: :customer

    delegate :name, :phone, :avatar, to: :employee, prefix: :employee

    def servicenames 
      self.event_services.map(&:service_name).join(', ')
    end

    def discountnames 
      self.event_services.map(&:disocunts_name).join(',')
    end

    def placename 
      Location.find_by_id( self.place_id).name if self.place_id.present? 
    end

    #! create unique number of event
    def create_number
      user = self.customer_id.to_s.rjust(5,"0") 
      number = "LGMD/#{user}-#{ Time.now.strftime('%d%m%y%H%M') }"
      self.number = number 
      self.save
    end

    #! calculate the total of the event for the associated services and discounts
    def total_services_amount
      total = 0
      self.event_services.each do |event_service|
        price = event_service.service_price if event_service.service_price.present?
        discount = event_service.discount_amount if event_service.discount_amount.present?
        discount = (price * event_service.discount_percentage) / 100  if event_service.discount_percentage.present?

        total_hours = event_service.overtime * event_service.service_hour_price

        #! save data on event_service
        event_service.total_amount = price - discount + total_hours
        event_service.save

        #! summation price, discounts and overtime
        total += event_service.total_amount
      end
      total
    end 

    scope :sort_by_date, -> { order('date ASC') }
    # ! SEARCH BETWEEN DATES
    scope :filter_between_dates, ->(start_date, end_date) { where(date: start_date..end_date) }
    scope :filter_by_employee_id, ->(employee_id) { where('employee_id = ?', employee_id) }
    
    # ! pgsearch busqueda por campos de texto
    # pg_search_scope :filter_by_number, against: :number
    pg_search_scope :filter_by_title, against: :title
    pg_search_scope :filter_by_status, against: :status
    
  end
end
