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

    def total_cart_amount(items)
      total_amount = 0
      items&.each do |item|
        total_amount += item&.service_price
      end
      total_amount
    end

    def pay_deposit(items)
      (self.total_cart_amount(items) * 20) / 100
    end
  end
end
