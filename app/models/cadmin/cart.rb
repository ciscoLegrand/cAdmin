module Cadmin
  class Cart < ApplicationRecord
    include AASM

    has_many :cart_items, dependent: :destroy
    has_many :services, through: :cart_items

    aasm.attribute_name :status

    aasm column: :status do
      state :pending, initial: true
      state :booking

      event :booked do
        transitions from: :pending, to: :booking
      end
    end

    def total_cart_amount
      self.cart_items.sum(&:service_price)
    end

    def deposit_percentage(percentage)
      self.total_cart_amount * percentage / 100
    end
  end
end
