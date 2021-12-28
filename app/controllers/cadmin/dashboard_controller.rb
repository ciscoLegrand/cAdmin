require_dependency "cadmin/application_controller"

module Cadmin
  class DashboardController < ApplicationController    
    
    add_breadcrumb 'Dashboard', :root_path

    def index
      add_breadcrumb 'Principal'
      @users = User.where(role: 'customer')
      tracks = Track.all
      tracks = tracks.filter_by_artist(params[:artist]) if params[:artist].present?
      
      

      @pagy, @tracks = pagy(tracks, items: 10)
    end

    def agenda
      add_breadcrumb 'Agenda'
    end
  end
end
