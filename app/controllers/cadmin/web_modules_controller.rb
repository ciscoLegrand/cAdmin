require_dependency "cadmin/application_controller"

module Cadmin
  class WebModulesController < ApplicationController
    before_action :set_web_module, only: [:show,:new, :edit, :update, :destroy]

    # GET /web_modules
    def index
      @web_modules = WebModule.all
    end

    # GET /web_modules/1
    def show
    end

    # GET /web_modules/new
    def new
      @web_module = WebModule.create_or_find_by(id: 1)
    end

    # GET /web_modules/1/edit
    def edit
    end

    # POST /web_modules
    def create
      @web_module = WebModule.new(web_module_params)

      if @web_module.save
        redirect_to @web_module, success: 'Web module was successfully created.'
      else
        render :new
      end
    end

    # PATCH/PUT /web_modules/1
    def update
      if @web_module.update(web_module_params)
        redirect_to edit_web_module_path(@web_module), success: t('.success')
      else
        render :edit
      end
    end

    # DELETE /web_modules/1
    def destroy
      @web_module.destroy
      redirect_to web_modules_url, success: 'Web module was successfully destroyed.'
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_web_module
        @web_module = WebModule.first
      end

      # Only allow a list of trusted parameters through.
      def web_module_params
        params.require(:web_module).permit(:blog, :gallery, :paypal, :stripe, :adyen, :opinions, :newsletter, :reservation,:mailbox, :invitable, :social_media)
      end
  end
end
