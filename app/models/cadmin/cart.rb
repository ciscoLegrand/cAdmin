module Cadmin
  class Cart < ApplicationRecord
    include AASM

    has_many :cart_items, dependent: :destroy
    has_many :services, through: :cart_items

    aasm column: :status do
      state :pending, initial: true
      state :booking

      event :booked do
        transitions from: :pending, to: :booking
      end
    end

    def pay_deposit(items)
      (self.total_cart_amount(items) * 20) / 100
    end
  end
end
