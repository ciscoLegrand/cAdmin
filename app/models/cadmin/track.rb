module Cadmin
  class Track < ApplicationRecord
    # extend FriendlyId

    # friendly_id :name, use: :slugged
    
    include PgSearch::Model
    include Cadmin::DateFormat

    def self.new_from_spotify_track(spotify_track)
      unless Track.exists?(spotify_id: spotify_track.id)
        Track.create!(
          spotify_id: spotify_track.id,
          name: spotify_track.name,
          artist: spotify_track.artists[0].name,
          image: spotify_track.album.images[0]["url"],
          preview: spotify_track.preview_url
        )
      end
    end

    def self.create_from_spotify(spotify_track)
      track = self.new_from_spotify_track(spotify_track)
      track.save
      track
    end

    pg_search_scope :filter_by_artist, against: :artist
  end
end
