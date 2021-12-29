module Cadmin
  class MainService < ApplicationRecord
    extend FriendlyId

    friendly_id :name, use: :slugged
    
    has_many :services
  end
end
