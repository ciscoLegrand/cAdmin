module Cadmin
  class EmailCustomTemplate < ApplicationRecord
    belongs_to :email_base_template
  
    validates :content, presence: true
  
    delegate :title, :kind, to: :email_base_template, prefix: 'base'
  end
end
