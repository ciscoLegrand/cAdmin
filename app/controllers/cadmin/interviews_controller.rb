require_dependency "cadmin/application_controller"

module Cadmin
  class InterviewsController < ApplicationController
    before_action :set_interview, only: [:show, :edit, :update, :destroy]

    # GET /interviews
    def index
      @interviews = Interview.all
    end

    # GET /interviews/1
    def show
    end

    # GET /interviews/new
    def new
      @interview = Interview.new
    end

    # GET /interviews/1/edit
    def edit
    end

    # POST /interviews
    def create
      @interview = Interview.new(interview_params)

      if @interview.save
        redirect_to @interview, notice: 'Interview was successfully created.'
      else
        render :new
      end
    end

    # PATCH/PUT /interviews/1
    def update
      if @interview.update(interview_params)
        redirect_to @interview, notice: 'Interview was successfully updated.'
      else
        render :edit
      end
    end

    # DELETE /interviews/1
    def destroy
      @interview.destroy
      redirect_to interviews_url, notice: 'Interview was successfully destroyed.'
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_interview
        @interview = Interview.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def interview_params
        params.require(:interview).permit(:event_id, :employee_id, :ceremony_music, :appetizer_music, :banquet_music, :ceremony_time, :entry, :bridal_dance, :garter, :garter_music, :figures, :figures_music, :gift_information, :observations)
      end
  end
end
