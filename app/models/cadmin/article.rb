module Cadmin
  class Article < ApplicationRecord
    include PgSearch::Model  
    include ImageUploader::Attachment(:image)
    belongs_to :user
    belongs_to :article_category
    
    has_many :comments
    delegate :username, :name, to: :user
    delegate :name, to: :article_category
    
    enum status: [:pendig, :published, :unpublished, :drafts ]

    validates :title, :content, :image, presence: true

    pg_search_scope :filter_by_search, against: [
      :title, 
      # :content, 
      # todo: complete searches
    ]
    
    def unpublish?
      self.status == 2
    end
  end
end
