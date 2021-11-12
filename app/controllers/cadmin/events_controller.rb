require_dependency "cadmin/application_controller"

module Cadmin
  class EventsController < ApplicationController
    before_action :set_event, only: [:show, :edit, :update, :destroy, :charged]
    add_breadcrumb 'Eventos', :events_path
    # GET /events
    def index      
      # @users = current_cadmin_user.where(deleted_at: nil).pluck(:id) #devuelve array de users´ids importante si hacemos soft delete de users  
      #! get events
      events = Event.where(customer_id: current_cadmin_user.id).order('date DESC') if current_cadmin_user.customer? || current_cadmin_user.employee?      
      events = Event.all.order('date DESC') if current_cadmin_user.admin?

      #! search events
      events = events.filter_by_number(params[:number]) if params[:number].present?
      events = events.filter_by_user_id(params[:user_id]) if params[:user_id].present?
      events = events.filter_between_dates(params['start_date'], params['end_date']) if params['start_date'].present? && params['end_date'].present?

      #! sort events
      # events= events.order(params[:sort])

      #! get total price events
      @total = employee_salary(events) if current_cadmin_user.employee?
      @total = total_events(events) if current_cadmin_user.admin? 
      #! number of events to show
      @events_count = events.present? ? events.count : 0
      #! paginate events
      @pagy, @events = pagy(events, items: 10 ) if @events.present? 
    end

    # GET /events/1
    def show
      add_breadcrumb @event.title
      @interview = Interview.find_by(event_id: @event.id)
    end

    # GET /events/new
    def new
      add_breadcrumb 'Nuevo Evento'
      @event = Event.new
      
      # @event.event_services.build
    end

    # GET /events/1/edit
    def edit
      add_breadcrumb 'Editar Evento'
      # @event.event_services.build
    end

    # POST /events
    def create
      
      @event = Event.new(event_params)  
      @event.create_number
      if @event.save
        
        @event.update(total_amount: @event.total_services_amount)
        redirect_to @event, notice: t('.success')
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
        redirect_to @event, notice: t('.success')
      else
        render :edit
      end
    end

    # DELETE /events/1
    def destroy
      
      @event.destroy
      redirect_to events_url, notice: 'Event was successfully destroyed.'
    end

    def charged 
      @event.update(charged: !@event.charged)
      #todo: review this to prevent
      redirect_to events_path
    end

    # TODO: refactor this method for validate type event and $
    def employee_salary(events)
      total = 0
      events.each do |event|
        if event.type_name == 'Boda'
          total +=  160 
        else
          total += 80
        end
      end
      total
    end

    def total_events(events)
      total = 0
      events.all.each do |event|
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
        params.require(:event).permit(:customer_id, :title, :type_name, :number, :date, :guests, :employee_id, 
                                      :place_id, :deposit, :total_amount, :charged, :observations, 
                                      event_services_attributes: [:_destroy, :id, :event_id, :service_id, :discount_id, :start_time, :overtime, :total_amount])
      end
  end
end
