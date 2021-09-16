module Cadmin
  class Article < ApplicationRecord
    belongs_to :user

    delegate :username, :name, to: :user

    validates :tittle, :content, presence: true
  end
end
