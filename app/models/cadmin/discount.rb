module Cadmin
  class Discount < ApplicationRecord
    extend FriendlyId

    friendly_id :name, use: :slugged
    validates :name, :type_discount, :percentage, :amount, presence: true
  end
end
