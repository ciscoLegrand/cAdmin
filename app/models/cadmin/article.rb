module Cadmin
  class Article < ApplicationRecord
    include ImageUploader::Attachment(:image)
    belongs_to :user

    delegate :username, :name, to: :user

    validates :title, :content, :image, presence: true
  end
end
