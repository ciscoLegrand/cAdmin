require_dependency "cadmin/application_controller"

module Cadmin
  class DashboardController < ApplicationController
    add_breadcrumb 'Dashboard', :root_path
    def index
      add_breadcrumb 'index'
    end
  end
end
