module Cadmin
  class Interview < ApplicationRecord
    include PgSearch::Model
    include Cadmin::DateFormat
    
    belongs_to :event
    belongs_to :employee, foreign_key: :employee_id, class_name: 'User'
    
    has_many :interview_options, dependent: :destroy    
    accepts_nested_attributes_for :interview_options, allow_destroy: true, reject_if: proc { |attr| attr['gift'].blank? }
    
    delegate :name, :phone, :avatar, to: :employee, prefix: :employee
    delegate :id, :title, :date, :customer_name, :customer_phone, :customer_email, :placename, to: :event, prefix: :event

    scope :filter_by_pending, -> {Time.now > Event.find(self.event_id).date}
    scope :filter_by_done, -> {Time.now <= Event.find(self.event_id).date}
  end
end
