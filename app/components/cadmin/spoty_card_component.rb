# frozen_string_literal: true

class Cadmin::SpotyCardComponent < ViewComponent::Base
  attr_reader :image, :name, :artist, :preview

  def initialize(image:, name:, artist:, preview:)
    @image = image
    @name = name
    @artist = artist
    @preview = preview
  end

  def render?
    @image.present? && @artist.present? 
  end
end
