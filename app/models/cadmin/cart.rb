module Cadmin
  class Cart < ApplicationRecord
    include AASM

    has_many :cart_items, dependent: :destroy
    has_many :services, through: :cart_items

    aasm column: :status do
      state :pending, initial: true
      state :booking
      state :canceled

      event :pay do
        transitions from: :pending, to: :booking
      end

      event :cancel do
        transitions from: [:pending, :booking], to: :canceled
      end
    end
  end
end
