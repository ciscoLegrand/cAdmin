module Cadmin
  class Discount < ApplicationRecord
    extend FriendlyId

    friendly_id :name, use: :slugged
  end
end
