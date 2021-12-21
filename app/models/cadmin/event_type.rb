module Cadmin
  class EventType < ApplicationRecord
    validates :name, presence: true, uniqueness: true 
    validates_presence_of :salary, :overtime_price
  end
end
