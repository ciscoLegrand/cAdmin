module Cadmin
  class Event < ApplicationRecord
    belongs_to :user

    delegate :name, to: :user, prefix: :user
    delegate :name, to: :location, prefix: :location
    delegate :name, to: :service, prefix: :service  # todo:  watcht why this doesnt work

    scope :sort_by_date, -> { order('date ASC') }

  end
end
