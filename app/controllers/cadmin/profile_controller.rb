require_dependency "cadmin/application_controller"

module Cadmin
  class ProfileController < ApplicationController
    def index
      add_breadcrumb 'Perfil'
    end
1
    def edit
    end

    def show
    end
  end
end
