require_dependency "cadmin/application_controller"

module Cadmin
  class ConversationsController < ApplicationController
    
    before_action :set_conversation, only: [:show, :edit, :update, :destroy]
    add_breadcrumb 'Mensajes', :conversations_path
    # GET /conversations
    def index
      @users = User.all if current_cadmin_user.admin?
      @users = get_customers if current_cadmin_user.employee?
      @users = get_employees if current_cadmin_user.customer?
      @conversations = Conversation.all
    end
    
    # GET /conversations/1
    def show
    end

    # GET /conversations/new
    def new
      @users = User.all if current_cadmin_user.admin?
      @users = get_customers if current_cadmin_user.employee?
      @users = get_employees if current_cadmin_user.customer?

      @conversation = Conversation.new
    end

    # GET /conversations/1/edit
    def edit
    end

    # POST /conversations
    def create
      if Conversation.between(params['sender_id'], params['recipient_id']).present?
        @conversation = Conversation.betweeen(params['sender_id']), params['recipient_id'].first
      else 
        @conversation = Conversation.create!(conversation_params)
      end 
      
      redirect_to conversation_messages_path(@conversation), notice: t('.success')
    end

    # PATCH/PUT /conversations/1
    def update
      if @conversation.update(conversation_params)
        redirect_to @conversation, notice: t('.success')
      else
        render :edit
      end
    end

    # DELETE /conversations/1
    def destroy
      @conversation.destroy
      redirect_to conversations_url, notice: 'Conversation was successfully destroyed.'
    end
    

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_conversation
        @conversation = Conversation.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def conversation_params
        params.require(:conversation).permit(:sender_id, :recipient_id, :title)
      end

      def get_customers 
        customers = []
        Event.where(employee_id: current_cadmin_user.id).each { |event| customers << User.find(event.customer_id) }
        customers
      end

      def get_employees
        employees = []      
        Event.where(customer_id: current_cadmin_user.id).each { |event| employees << User.find(event.employee_id) }      
        employees
      end
  end
end
