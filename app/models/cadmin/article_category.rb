module Cadmin
  class ArticleCategory < ApplicationRecord
    has_many :articles, dependent: :destroy
    validates :name, presence: true
  end
end
