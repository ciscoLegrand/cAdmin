module Cadmin
  class Event < ApplicationRecord
    belongs_to :user
  end
end
