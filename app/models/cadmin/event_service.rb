module Cadmin
  class EventService < ApplicationRecord
    belongs_to :event
    belongs_to :service, optional: true
    belongs_to :discount, optional: true

    delegate :name, :price, :hour_price, :stock, to: :service, prefix: 'service'
    delegate :name, :type_discount, :percentage, :amount, to: :discount, prefix: 'discount' 
  end
end
