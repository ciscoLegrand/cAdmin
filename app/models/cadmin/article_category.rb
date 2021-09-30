module Cadmin
  class ArticleCategory < ApplicationRecord
    has_many :articles
  end
end
