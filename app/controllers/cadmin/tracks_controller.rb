require_dependency "cadmin/application_controller"

module Cadmin 
  class TracksController < ApplicationController
    def index 
      tracks = Track.all.order(created_at: :desc)
      tracks = tracks.filter_by_artist(params[:artist]) if params[:artist].present?    

      @pagy, @tracks = pagy(tracks, items: 12)
    end
  end
end