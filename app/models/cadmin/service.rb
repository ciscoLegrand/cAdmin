module Cadmin
  class Service < ApplicationRecord
    extend FriendlyId

    friendly_id :name, use: :slugged

    include PgSearch::Model  
    include ImageUploader::Attachment(:image)
    
    belongs_to :main_service
    # todo: control stock by days
    def no_vat 
      (self.price / "1.#{self.vat}".to_f).round(2)
    end
  end
end
