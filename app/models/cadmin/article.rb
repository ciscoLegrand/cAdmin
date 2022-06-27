module Cadmin
  class Article < ApplicationRecord
    extend FriendlyId

    friendly_id :title, use: :slugged
    
    include PgSearch::Model  
    include ImageUploader::Attachment(:image)
    
    belongs_to :user
    belongs_to :article_category
    
    has_many :comments, dependent: :destroy
    has_many :taggings, dependent: :destroy
    has_many :tags, through: :taggings

    serialize :tag_ids, Array

    delegate :username, :name, to: :user
    delegate :name, to: :article_category, prefix: :category
    
    enum status: [:pending, :published, :unpublished, :drafts ]

    validates :title, :content, presence: true

    def self.tagged_with(name)
      Tag.find_by!(name: name).articles
    end

    def self.tag_counts
      Tag.select('tags.*, count(taggings.tag_id) as count').joins(:taggings).group('taggings.tag_id')
    end

    def tag_list 
      tags.map(&:name).join(', ')
    end

    def tag_list=(names)
      self.tags = names.split(',').map do |n|
        Tag.where(name: n.strip).first_or_create!
      end
    end

    pg_search_scope :filter_by_search, against: [
      :title, 
      # :content, 
      # todo: complete searches
    ]
    
    def unpublish?
      self.status == 2
    end

    def draft?
      self.status == 3
    end
  end
end
