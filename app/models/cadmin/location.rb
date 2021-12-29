module Cadmin
  class Location < ApplicationRecord
    extend FriendlyId

    friendly_id :name, use: :slugged
  end
end
