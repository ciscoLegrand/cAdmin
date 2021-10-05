module Cadmin
  class ArticleCategory < ApplicationRecord
    has_many :articles, dependent: :destroy
  end
end
