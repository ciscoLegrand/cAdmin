module Cadmin
  class Event < ApplicationRecord
    belongs_to :employee # user
    belongs_to :substitute #user
  end
end
