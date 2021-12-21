require_dependency "cadmin/application_controller"

module Cadmin
  class DashboardController < ApplicationController    
    
    add_breadcrumb 'Dashboard', :root_path

    def index
      add_breadcrumb 'Principal'
      @users = User.where(role: 'customer')

      
        @q = params[:q]
        if @q
          tracks = Track.where(name: @q)
        else
          tracks = Track.all.order(created_at: 'DESC')
         end
      @pagy, @tracks = pagy(tracks, items: 10)
    end

    def agenda
      add_breadcrumb 'Agenda'
    end
  end
end
