module Cadmin
  class Article < ApplicationRecord
    include ImageUploader::Attachment(:image)
    belongs_to :user
    has_many :comments
    delegate :username, :name, to: :user

    validates :title, :content, :image, presence: true
  end
end
