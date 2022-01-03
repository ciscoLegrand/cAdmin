module Cadmin
  class CartItem < ApplicationRecord
    belongs_to :service
    belongs_to :cart
  end
end
