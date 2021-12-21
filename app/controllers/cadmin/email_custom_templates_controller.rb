require_dependency "cadmin/application_controller"

module Cadmin
  class EmailCustomTemplatesController < ApplicationController
    before_action :set_email_base_template 
    before_action :set_email_custom_template, only: %i[ show  edit update destroy ]

    # GET /email_custom_templates
    def index
      @email_custom_templates = @email_base_template.email_custom_templates
    end

    # GET /email_custom_templates/1
    def show
    end

    # GET /email_custom_templates/new
    def new
      @email_custom_template = @email_base_template.email_custom_templates.build
    end

    # GET /email_custom_templates/1/edit
    def edit
    end

    # POST /email_custom_templates
    def create
      @email_custom_template = @email_base_template.email_custom_templates.build(email_custom_template_params)

      if @email_custom_template.save
        redirect_to email_base_templates_path, notice: 'Email custom template was successfully created.'
      else
        render :new
      end
    end

    # PATCH/PUT /email_custom_templates/1
    def update
      if @email_custom_template.update(email_custom_template_params)
        redirect_to email_base_templates_path, notice: 'Email custom template was successfully updated.'
      else
        render :edit
      end
    end

    # DELETE /email_custom_templates/1
    def destroy
      @email_custom_template.destroy
      redirect_to email_custom_templates_url, notice: 'Email custom template was successfully destroyed.'
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_email_custom_template
        @email_custom_template = @email_base_template.email_custom_templates.find_or_initialize_by(id: params[:id])
      end

      def set_email_base_template
        @email_base_template = EmailBaseTemplate.find(params[:email_base_template_id])
      end

      # Only allow a list of trusted parameters through.
      def email_custom_template_params
        params.require(:email_custom_template).permit(:content, :email_base_template_id)
      end
  end
end
