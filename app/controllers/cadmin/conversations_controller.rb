require_dependency "cadmin/application_controller"

module Cadmin
  class ConversationsController < ApplicationController
    
    before_action :set_conversation, only: [:show, :edit, :update, :destroy]
    add_breadcrumb 'Mensajes', :conversations_path
    # GET /conversations
    def index
      @users = User.all
      @conversations = Conversation.all
    end

    # GET /conversations/1
    def show

    end

    # GET /conversations/new
    def new
      add_breadcrumb 'Nueva conversación'
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
      
      redirect_to conversation_messages_path(@conversation), notice: 'Conversation was successfully created.'
    end

    # PATCH/PUT /conversations/1
    def update
      if @conversation.update(conversation_params)
        redirect_to @conversation, notice: 'Conversation was successfully updated.'
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
  end
end
