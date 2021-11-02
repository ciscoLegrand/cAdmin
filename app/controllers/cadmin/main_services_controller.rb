require_dependency "cadmin/application_controller"

module Cadmin
  class MainServicesController < ApplicationController
    before_action :set_main_service, only: [:show, :edit, :update, :destroy]
    
    # GET /main_services
    def index
      @main_services = MainService.all
    end

    # GET /main_services/1
    def show
    end

    # GET /main_services/new
    def new
      add_breadcrumb 'Nuevo servicio'
      @main_service = MainService.new
    end

    # GET /main_services/1/edit
    def edit
    end

    # POST /main_services
    def create
      @lastposition = MainService.last.position
      @main_service = MainService.new(main_service_params)
      @main_service.position = @lastposition.to_i + 1
      
      if @main_service.save
        redirect_to @main_service, notice: 'Main service was successfully created.'
      else
        render :new
      end
    end

    # PATCH/PUT /main_services/1
    def update
      if @main_service.update(main_service_params)
        redirect_to @main_service, notice: 'Main service was successfully updated.'
      else
        render :edit
      end
    end

    # DELETE /main_services/1
    def destroy
      @main_service.destroy
      redirect_to main_services_url, notice: 'Main service was successfully destroyed.'
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_main_service
        @main_service = MainService.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def main_service_params
        params.require(:main_service).permit(:name, :description, :position)
      end
  end
end
