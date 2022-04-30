require_dependency "cadmin/application_controller"

module Cadmin
  class EventsController < ApplicationController
    skip_before_action :authenticate_cadmin_user!, only: %w[new create]
    before_action :set_event, only: %w[show edit update destroy charged cancel booked]
    before_action :set_cart, only: %w[new create]

    add_breadcrumb 'Eventos', :events_path
    # GET /events
    def index      
      # @users = current_cadmin_user.where(deleted_at: nil).pluck(:id) #devuelve array de users´ids importante si hacemos soft delete de users  
      #! get events
      event = Event.includes([:event_services, :event_type, :place, :employee])
      events = event.where(customer_id: current_cadmin_user.id) if current_cadmin_user.customer? 
      events = event.where(employee_id: current_cadmin_user.id) if current_cadmin_user.employee?      
      events = event.all if current_cadmin_user.admin?

      #! search events
      events = events.filter_by_number(params[:number]) if params[:number].present?
      events = events.filter_by_title(params[:title]) if params[:title].present?
      events = events.filter_by_employee_id(params[:employee_id]) if params[:employee_id].present?
      events = events.filter_between_dates(params['start_date'], params['end_date']) if params['start_date'].present? && params['end_date'].present?
      events = events.filter_by_status(params[:status]) if params[:status].present?
      #! sort events
      # events= events.order(params[:sort])

      #! get total price events
      @total = employee_salary(events) if current_cadmin_user.employee?
      @total = total_events(events) if current_cadmin_user.admin? 
      @pending_amount = pending_amount(events) if current_cadmin_user.admin?
      @deposits = @total - @pending_amount if current_cadmin_user.admin?
      #! number of events to show
      @events_count = events.present? ? events.count : 0
      #! paginate events
      @pagy, @events = pagy(events.order(created_at: :desc), items: 10) if @events.present? && events.present?
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
      @event_types = Cadmin::EventType.all
      @total_cart_amount = @cart.total_cart_amount if @cart.present?
    end

    # GET /events/1/edit
    def edit
      add_breadcrumb 'Editar Evento'
      @event_types = Cadmin::EventType.all
    end

    # POST /events
    def create
      @event = Event.new(event_params)  
      @event.create_number
      
      if @event.save
        # update role and create customer on stripe
        current_cadmin_user.create_stripe_customer if current_cadmin_user.user?
        @event.update(total_amount: @event.total_services_amount)
        @event.event_services.each do |es|
          #! stock's control by dates
          if StockByDate.find_by(service_id: es.service_id, date: @event.date).present?
            stocks = Service.find(es.service_id).stock_by_dates.find_by(service_id: es.service_id, date: @event.date)
            stocks.update(stock: stocks.stock - 1 )
          else 
            service = Service.find(es.service_id)
            service.stock_by_dates.create!(stock: service.stock - 1 , date: @event.date)
          end
        end
        redirect_to @event, success: t('.success')
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
        redirect_to @event, success: t('.success')
      else
        render :edit
      end
    end

    # DELETE /events/1
    def destroy      
      @event.destroy
      redirect_to events_url, success: t('.success')
    end
    
    def booked
      @event.book!
      redirect_to events_path
    end

    def charged 
      @event.pay!
      @event.update(charged: true)
      redirect_to events_path
    end

    def cancel 
      @event.update(total_amount: 0)
      #! restore service's stock
      @event.event_services.each do |es|
        service = Service.find(es.service_id).stock_by_dates.find_by(service_id: es.service_id, date: @event.date)
        service.update(stock: service.stock + 1 )
      end
      @event.cancel!
      redirect_to events_path
    end

    def employee_salary(events)
      def is_collectible?(service)
        Cadmin::Service.find(service.service_id).main_service_id == Cadmin::MainService.find_by(name: 'Cabinas').id
      end
      total = 0
      events.each do |event| 
        type = Cadmin::EventType.find_by(name: event.type_name)
        services = Cadmin::EventService.where(event_id: event.id)
        services.each { |service| total += service.overtime * type.overtime_price if is_collectible?(service) }
        total += type.salary
      end
      total
    end

    #! total amount of all events
    def total_events(events)
      events.sum(&:total_amount)
    end

    def pending_amount(events)
      total = 0
      events.where(charged: false).each { |event| total += event.total_services_amount - event.deposit unless event.cancelled? }
      total
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_event
        @event = Event.friendly.find(params[:id])
      end
      # Only allow a list of trusted parameters through.
      def event_params
        params.require(:event).permit(:customer_id, :cart_id, :title, :event_type_id, :number, :date, :guests, :employee_id, 
                                      :place_id, :deposit, :total_amount, :charged, :observations, :status,
                                      event_services_attributes: [:_destroy, :id, :event_id, :service_id, :discount_id, :start_time, :overtime, :total_amount])
      end

      def set_cart 
        @cart = Cart.find(session[:cart_id]) unless session[:cart_id].nil?
      end 
  end
end
