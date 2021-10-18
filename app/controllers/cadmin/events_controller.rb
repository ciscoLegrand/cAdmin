require_dependency "cadmin/application_controller"

module Cadmin
  class EventsController < ApplicationController
    before_action :set_event, only: [:show, :edit, :update, :destroy]

    # GET /events
    def index      
      events = Event.all
      # @users = current_cadmin_user.where(deleted_at: nil).pluck(:id) #devuelve array de users´ids
      # events = current_cadmin_user.admin? ? Event.all : current_cadmin_user.events.all 
      events = events.where(customer_id: current_cadmin_user.id) if current_cadmin_user.customer?
      events = events.where(employee_id: current_cadmin_user.id) if current_cadmin_user.employee?
      events = events if current_cadmin_user.admin?
      # events = current_cadmin_user.events.where(customer_id: current_cadmin_user.id) if current_cadmin_user.where(role: 'customer')
      @events= events.order(params[:sort])
      @total = employee_salary(@events)
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
        if @event.employee_id.present?
          @conversation = Cadmin::Conversation
          if @conversation.where(recipient_id: @event.employee_id).first.present?            
            @message = @conversation.where(recipient_id: @event.employee_id).first.messages.create(body:"<a href='#{events_path}'>Tienes un nuevo evento: #{@event.date}</a>", user_id: current_cadmin_user.id)         
          else
            @conversation.create(sender_id:current_cadmin_user.id, recipient_id:@event.employee_id )
            @message = @conversation.messages.create(body:"<a href='#{events_path}'>Tienes un nuevo evento: #{@event.date}</a>", user_id: current_cadmin_user.id)
          end
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

         
    # TODO: refactor this method for validate type event and $
    def employee_salary(events)
      total = 0
      events.each do |event|
        total += event.extra_hours.present? ? 160 + (event.extra_hours * 40) : 160
      end
      total
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_event
        @event = Event.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def event_params
        params.require(:event).permit(:customer_id, :type_name, :number, :date, :guests, :start_time, :extra_hours, :employee_id, :place_id, :deposit, :total_amount, :charged, :observations, service_ids: [])
      end
  end
end
