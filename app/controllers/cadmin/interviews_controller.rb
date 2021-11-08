require_dependency "cadmin/application_controller"

module Cadmin
  class InterviewsController < ApplicationController
    before_action :set_interview, only: [:show, :edit, :update, :destroy]
    before_action :set_event, only: [:show,:new,:create,:edit,:uptade,:destroy]
    add_breadcrumb 'Entrevistas', :interviews_path
    # GET /interviews
    def index      
      #! get interviews
      
      # @users = current_cadmin_user.where(deleted_at: nil).pluck(:id) #devuelve array de users´ids 
      @interviews = current_cadmin_user.admin? ? Interview.all : Interview.where(employee_id: current_cadmin_user.id)
    end

    # GET /interviews/1
    def show
      add_breadcrumb @interview.event_title.present? ? @interview.event_title : @interview.event_customer_name
    end

    # GET /interviews/new
    def new      
      add_breadcrumb 'Nueva Entrevista'
      #! has_one asociations build method -> https://stackoverflow.com/questions/2472982/rails-using-build-with-a-has-one-association-in-rails
      @interview = @event.build_interview
      # @interview.interview_options.build 
    end
    # GET /interviews/1/edit
    def edit
      add_breadcrumb 'Editar Entrevista'
    end

    # POST /interviews
    def create
      @interview = @event.build_interview(interview_params)

      if @interview.save
        redirect_to event_interviews_path, notice: t('.success')
      else
        render :new
      end
    end

    # PATCH/PUT /interviews/1
    def update
      if @interview.update(interview_params)
        redirect_to events_path, notice: t('.success')
      else
        render :edit
      end
    end

    # DELETE /interviews/1
    def destroy
      @interview = Interview.find(params[:id])
      @interview.destroy
      redirect_to interviews_url, notice: 'Interview was successfully destroyed.'
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_interview
        @interview = Event.find(params[:event_id]).interview
      end
      def set_event 
        @event = Event.find(params[:event_id]) 
      end

      # Only allow a list of trusted parameters through.
      def interview_params
        params.require(:interview).permit(:event_id, :employee_id, :ceremony_music, :appetizer_music, :banquet_music, :ceremony_time, :entry, 
                                          :bridal_dance,:garter, :garter_music, :figures, :figures_music, :gift_information, :observations,
                                          interview_options_attributes: [:_destroy, :id, :gift, :song])
      end
  end
end
