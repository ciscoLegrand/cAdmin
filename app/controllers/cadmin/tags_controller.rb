require_dependency "cadmin/application_controller"

module Cadmin
  class TagsController < ApplicationController
    before_action :set_tag, only: [:show, :edit, :update, :destroy]
    add_breadcrumb 'Tags', :tags_path
    # GET /tags
    def index
      @tags = Tag.all
    end

    # GET /tags/1
    def show
      add_breadcrumb @tag.name
    end

    # GET /tags/new
    def new
      add_breadcrumb 'Nuevo Tag'
      @tag = Tag.new
    end

    # GET /tags/1/edit
    def edit
      add_breadcrumb "Editar #{@tag.name}"
    end

    # POST /tags
    def create
      @tag = Tag.new(tag_params)

      if @tag.save
        redirect_to new_tag_path, notice: 'Article category was successfully created.'
      else
        render :new
      end
    end

    # PATCH/PUT /tags/1
    def update
      if @tag.update(tag_params)
        redirect_to @tag, notice: 'Article category was successfully updated.'
      else
        render :edit
      end
    end

    # DELETE /tags/1
    def destroy
      @tag.destroy
      redirect_to tag_url, notice: 'Article category was successfully destroyed.'
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_tag
        @tag = Tag.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def tag_params
        params.require(:tag).permit(:name)
      end
  end
end
