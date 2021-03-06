require_dependency "cadmin/application_controller"

module Cadmin
  class ServicesController < ApplicationController
    before_action :set_main_service, only: %w[index show new create edit uptade destroy]
    before_action :set_service, only: %w[show edit update destroy]
    # GET /services
    def index 
      add_breadcrumb @main.name
      @services = @main.services.all
    end

    # GET /services/1
    def show
      add_breadcrumb @main.name
      add_breadcrumb @service.name
      @services = @main.services.all
    end

    # GET /services/new
    def new
      add_breadcrumb @main.name
      add_breadcrumb "Nueva #{@main.name.singularize}"
      @service = @main.services.build
    end

    # GET /services/1/edit
    def edit
      @service = @main.services.friendly.find(params[:id])
      add_breadcrumb @main.name
      add_breadcrumb "Editar #{@service.name}"
    end

    # POST /services
    def create
      @service = @main.services.build(service_params)
      @service.price_no_vat = @service.no_vat

      if @service.save
        redirect_to main_service_services_path, success: t('.success')
      else
        render :new
      end
    end

    # PATCH/PUT /services/1
    def update
      if @service.update(service_params)
        @service.update(price_no_vat: @service.no_vat) 
        redirect_to main_service_services_path, success: t('.success')
      else
        render :edit
      end
    end

    # DELETE /services/1
    def destroy
      @service = @main.services.find(params[:id])

      @service.destroy
      redirect_to services_url, success: t('.success')
    end

    private
      def set_main_service 
        @main = MainService.friendly.find(params[:main_service_id])
      end
      # Use callbacks to share common setup or constraints between actions.
      def set_service
        @service = Service.friendly.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def service_params
        params.require(:service).permit(:name, :short_dscription, :description, :metatitle, :metadescription, :features, 
                                        :stock, :price, :vat, :price_no_vat, :hour_price, :main_service_id,:image)
      end
  end
end
