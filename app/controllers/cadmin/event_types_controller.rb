require_dependency "cadmin/application_controller"

module Cadmin
  class EventTypesController < ApplicationController
    before_action :set_event_type, only: [:show, :edit, :update, :destroy]
    add_breadcrumb 'Tipos de evento', :event_types_path
    # GET /event_types
    def index
      @event_types = EventType.all
    end

    # GET /event_types/1
    def show
    end

    # GET /event_types/new
    def new
      add_breadcrumb 'Nuevo tipo'
      @event_type = EventType.new
    end

    # GET /event_types/1/edit
    def edit
      add_breadcrumb 'Editar tipo'
    end

    # POST /event_types
    def create
      @event_type = EventType.new(event_type_params)

      if @event_type.save
        redirect_to @event_type, notice: 'Event type was successfully created.'
      else
        render :new
      end
    end

    # PATCH/PUT /event_types/1
    def update
      if @event_type.update(event_type_params)
        redirect_to @event_type, notice: 'Event type was successfully updated.'
      else
        render :edit
      end
    end

    # DELETE /event_types/1
    def destroy
      @event_type.destroy
      redirect_to event_types_url, notice: 'Event type was successfully destroyed.'
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_event_type
        @event_type = EventType.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def event_type_params
        params.require(:event_type).permit(:name, :salary, :overtime_price, :assemble)
      end
  end
end
