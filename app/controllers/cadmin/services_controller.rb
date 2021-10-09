require_dependency "cadmin/application_controller"

module Cadmin
  class ServicesController < ApplicationController
    before_action :set_main_service, only: [:index,:show,:new,:create,:edit,:uptade,:destroy]
    before_action :set_service, only: [:show, :edit, :update, :destroy]
    # GET /services
    def index
      @services = @main.services.all
    end

    # GET /services/1
    def show
    end

    # GET /services/new
    def new
      @service = @main.services.build
    end

    # GET /services/1/edit
    def edit
      @service = @main.services.find(params[:id])
    end

    # POST /services
    def create
      @service = @main.services.build(service_params)

      if @service.save
        redirect_to main_service_services_path, notice: 'Service was successfully created.'
      else
        render :new
      end
    end

    # PATCH/PUT /services/1
    def update
      if @service.update(service_params)
        redirect_to main_service_services_path, notice: 'Service was successfully updated.'
      else
        render :edit
      end
    end

    # DELETE /services/1
    def destroy
      @service = @main.services.find(params[:id])

      @service.destroy
      redirect_to services_url, notice: 'Service was successfully destroyed.'
    end

    private
      def set_main_service 
        @main = MainService.find_by_id(params[:main_service_id])
      end
      # Use callbacks to share common setup or constraints between actions.
      def set_service
        @service = Service.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def service_params
        params.require(:service).permit(:name, :short_dscription, :description, :metatitle, :metadescription, :features, :price, :hour_price, :extra_hour, :initial_hours, :main_service_id,:image)
      end
  end
end
