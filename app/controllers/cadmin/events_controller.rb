require_dependency "cadmin/application_controller"

module Cadmin
  class EventsController < ApplicationController
    before_action :set_event, only: [:show, :edit, :update, :destroy]

    # GET /events
    def index
      
      # @users = current_cadmin_user.where(deleted_at: nil).pluck(:id) #devuelve array de users´ids
      @events = current_cadmin_user.admin? ? Event.all : current_cadmin_user.events.all
    end

    # GET /events/1
    def show
    end

    # GET /events/new
    def new
      @event = Event.new
    end

    # GET /events/1/edit
    def edit
    end

    # POST /events
    def create
      @event = Event.new(event_params)

      if @event.save
        redirect_to @event, notice: 'Event was successfully created.'
      else
        render :new
      end
    end

    # PATCH/PUT /events/1
    def update
      if @event.update(event_params)
        if @event.user_id.present?
          # todo:  sending a message that a new event is added to user events! 
        end
        redirect_to @event, notice: 'Event was successfully updated.'
      else
        render :edit
      end
    end

    # DELETE /events/1
    def destroy
      @event.destroy
      redirect_to events_url, notice: 'Event was successfully destroyed.'
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_event
        @event = Event.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def event_params
        params.require(:event).permit(:name, :type_name, :number, :date, :guests, :start_time, :extra_hours, :user_id, :place_id, :deposit, :total_amount, :charged, :observations, service_ids: [])
      end
  end
end
