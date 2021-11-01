module Cadmin
  class Interview < ApplicationRecord
    belongs_to :event
    belongs_to :employee, foreign_key: :employee_id, class_name: 'User'
    has_many :interview_options, dependent: :destroy    
    accepts_nested_attributes_for :interview_options, allow_destroy: true, reject_if: proc { |attr| attr['gift'].blank? }
    
    delegate :name, :phone, :avatar, to: :employee, prefix: :employee

  end
end
