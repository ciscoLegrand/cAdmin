require_dependency "cadmin/application_controller"

module Cadmin
  class EventsController < ApplicationController
    before_action :set_event, only: [:show, :edit, :update, :destroy]

    # GET /events
    def index      
      #! get events
      # @users = current_cadmin_user.where(deleted_at: nil).pluck(:id) #devuelve array de users´ids      
      events = Event.where(customer_id: current_cadmin_user.id).order('date DESC') if current_cadmin_user.customer?
      events = Event.where(employee_id: current_cadmin_user.id).order('date DESC') if current_cadmin_user.employee?
      events = Event.all.order('date DESC') if current_cadmin_user.admin?
      # events = current_cadmin_user.events.where(customer_id: current_cadmin_user.id) if current_cadmin_user.where(role: 'customer')

      #! search events
      events = events.filter_by_number(params[:number]) if params[:number].present?
      events = events.filter_by_user_id(params[:user_id]) if params[:user_id].present?
      events = events.filter_between_dates(params['start_date'], params['end_date']) if params['start_date'].present? && params['end_date'].present?

      #! sort events
      events= events.order(params[:sort])

      #! get total price events
      @total = employee_salary(events) if current_cadmin_user.employee?
      @total = total_event(events) if current_cadmin_user.admin? 
      
      #! paginate events
      @pagy, @events = pagy(events, items: 10 )
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
      @event.total_amount = @event.total_services_amount
      if @event.save
        redirect_to @event, notice: 'Event was successfully created.'
      else
        render :new
      end
    end

    # PATCH/PUT /events/1
    def update
      if @event.update(event_params)        
        @event.update(total_amount: @event.total_services_amount)
        if @event.employee_id.present?
          @conversation = Cadmin::Conversation
          if @conversation.where(recipient_id: @event.employee_id).first.present?            
            @message = @conversation.where(recipient_id: @event.employee_id).first.messages.create(body:"<a href='#{events_path}'>Tienes un nuevo evento: #{@event.date}</a>", user_id: current_cadmin_user.id)         
          else
            @conversation = @conversation.create(sender_id:current_cadmin_user.id, recipient_id:@event.employee_id )
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
        if event.type_name == 'Boda'
          total +=  160 + (event.extra_hours * 40) 
        else
          total += 80 + (event.extra_hours * 20) 
        end
      end
      total
    end

    def total_event(events)
      total = 0
      events.each do |event|
        total += event.total_services_amount
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
        params.require(:event).permit(:customer_id, :title, :type_name, :number, :date, :guests, :start_time, :extra_hours, :employee_id, :place_id, :deposit, :total_amount, :charged, :observations,service_ids: [], discount_ids: [])
      end
  end
end
