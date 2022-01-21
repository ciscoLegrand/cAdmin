module Cadmin 
  class TrackSerializer < ActiveModel::Serializer 
    attributes :id, :name, :artists, :image, :preview, :spotify_id
  end
end
