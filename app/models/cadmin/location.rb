module Cadmin
  class Location < ApplicationRecord
    extend FriendlyId

    friendly_id :name, use: :slugged

    validates :name, presence: true
  end
end
