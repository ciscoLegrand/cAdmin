module Cadmin
  class Tag < ApplicationRecord
    has_many :taggings
    has_many :articles, through: :taggings

    validates :name, null: false, uniqueness: true
  end
end
