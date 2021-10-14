require_dependency "cadmin/application_controller"

module Cadmin
  class MessagesController < ApplicationController
    before_action :set_message, only: [:show, :edit, :update, :destroy]
    before_action :set_conversation

    # GET /messages
    def index
      @messages = @conversation.messages
      @message = @conversation.messages.new
    end

    # GET /messages/1
    def show
    end

    # GET /messages/new
    def new
      @message = @conversation.messages.new
    end

    # GET /messages/1/edit
    def edit
    end

    # POST /messages
    def create
      @message = @conversation.messages.new(message_params)

      if @message.save
        redirect_to conversation_messages_path(@conversation), notice: 'Message was successfully created.'
      else
        render :new
      end
    end

    # PATCH/PUT /messages/1
    def update
      if @message.update(message_params)
        redirect_to @message, notice: 'Message was successfully updated.'
      else
        render :edit
      end
    end

    # DELETE /messages/1
    def destroy
      @message.destroy
      redirect_to messages_url, notice: 'Message was successfully destroyed.'
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_message
        @message = Message.find(params[:id])
      end

      def set_conversation 
        @conversation = Conversation.find(params[:conversation_id])
      end

      # Only allow a list of trusted parameters through.
      def message_params
        params.require(:message).permit(:body, :user_id)
      end
  end
end
