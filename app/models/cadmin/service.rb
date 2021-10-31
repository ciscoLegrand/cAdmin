module Cadmin
  class Service < ApplicationRecord
    include PgSearch::Model  
    include ImageUploader::Attachment(:image)
    belongs_to :main_service

    def no_vat 
      (self.price / "1.#{self.vat}".to_f).round(2)
    end
  end
end
