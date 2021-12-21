require_dependency "cadmin/application_controller"

module Cadmin
  class EmailBaseTemplatesController < ApplicationController
    before_action :set_email_base_template, only: [:show, :edit, :update, :destroy]
    add_breadcrumb "Plantillas", '/email_base_templates'
    # GET /email_base_templates
    def index
      @email_base_templates = EmailBaseTemplate.all
    end

    # GET /email_base_templates/1
    def show
      template = @email_base_template.has_custom_template? ? @email_base_template.custom_template : @email_base_template
      @template = Liquid::Template.parse(template.content) 
    end

    # GET /email_base_templates/new
    def new
      add_breadcrumb 'Nueva'
      @email_base_template = EmailBaseTemplate.new
    end

    # GET /email_base_templates/1/edit
    def edit
      add_breadcrumb 'Editar'
    end

    # POST /email_base_templates
    def create
      @email_base_template = EmailBaseTemplate.new(email_base_template_params)

      if @email_base_template.save
        redirect_to @email_base_template, notice: 'Email base template was successfully created.'
      else
        render :new
      end
    end

    # PATCH/PUT /email_base_templates/1
    def update
      if @email_base_template.update(email_base_template_params)
        redirect_to @email_base_template, notice: 'Email base template was successfully updated.'
      else
        render :edit
      end
    end

    # DELETE /email_base_templates/1
    def destroy
      @email_base_template.destroy
      redirect_to email_base_templates_url, notice: 'Email base template was successfully destroyed.'
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_email_base_template
        @email_base_template = EmailBaseTemplate.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def email_base_template_params
        params.require(:email_base_template).permit(:title, :content, :kind)
      end
  end
end
