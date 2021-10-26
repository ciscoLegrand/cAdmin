module Cadmin
  class Interview < ApplicationRecord
    belongs_to :event
    belongs_to :employee, foreign_key: :employee_id, class_name: 'User'
  end
end
