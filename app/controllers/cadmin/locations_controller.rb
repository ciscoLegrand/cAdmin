require_dependency "cadmin/application_controller"

module Cadmin
  class LocationsController < ApplicationController
    before_action :set_location, only: [:show, :edit, :update, :destroy]
    add_breadcrumb 'Restaurantes', :locations_path
    # GET /locations
    def index
      @locations = Location.all
    end

    # GET /locations/1
    def show
      add_breadcrumb @location.name
    end

    # GET /locations/new
    def new
      add_breadcrumb 'Nuevo Restaurante'
      @location = Location.new
    end

    # GET /locations/1/edit
    def edit
      add_breadcrumb 'Editar Restaurante'
    end

    # POST /locations
    def create
      @location = Location.new(location_params)

      if @location.save
        redirect_to @location, success: t('.success')
      else
        render :new
      end
    end

    # PATCH/PUT /locations/1
    def update
      if @location.update(location_params)
        redirect_to @location, success: t('.success')
      else
        render :edit
      end
    end

    # DELETE /locations/1
    def destroy
      @location.destroy
      redirect_to locations_url, success: t('.success')
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_location
        @location = Location.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def location_params
        params.require(:location).permit(:name, :address, :postal_code, :province, :coords)
      end
  end
end
