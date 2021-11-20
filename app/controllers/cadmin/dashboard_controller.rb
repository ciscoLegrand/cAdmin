require_dependency "cadmin/application_controller"

module Cadmin
  class DashboardController < ApplicationController    
    
    add_breadcrumb 'Dashboard', :root_path

    def index
      add_breadcrumb 'Principal'
      @users = User.where(role: 'customer')
    end

    def agenda
      add_breadcrumb 'Agenda'
    end
  end
end
