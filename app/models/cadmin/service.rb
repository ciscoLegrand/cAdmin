module Cadmin
  class Service < ApplicationRecord
    include PgSearch::Model  
    include ImageUploader::Attachment(:image)
    belongs_to :main_service
  end
end
