require_dependency "cadmin/application_controller"

module Cadmin
  class DashboardController < ApplicationController
    before_action :authenticate_user!, only: [:index]
    
    add_breadcrumb 'Dashboard', :root_path

    def index
      add_breadcrumb 'Principal'
    end
  end
end
