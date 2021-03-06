require_dependency "cadmin/application_controller"

module Cadmin
  class ArticleCategoriesController < ApplicationController
    before_action :set_article_category, only: [:show, :edit, :update, :destroy]
    add_breadcrumb 'Categorías', :article_categories_path
    # GET /article_categories
    def index
      @article_categories = ArticleCategory.all
    end

    # GET /article_categories/1
    def show
      add_breadcrumb @article_category.name
    end

    # GET /article_categories/new
    def new
      add_breadcrumb 'Nueva Categoría'
      @article_category = ArticleCategory.new
    end

    # GET /article_categories/1/edit
    def edit
      add_breadcrumb "Editar #{@article_category.name}"
    end

    # POST /article_categories
    def create
      @article_category = ArticleCategory.new(article_category_params)

      if @article_category.save
        redirect_to @article_category, success: t('.success')
      else
        render :new
      end
    end

    # PATCH/PUT /article_categories/1
    def update
      if @article_category.update(article_category_params)
        redirect_to @article_category, success: t('.success')
      else
        flash.now[:alert] = 'Algo ha salido mal' 
        render :edit
      end
    end

    # DELETE /article_categories/1
    def destroy
      @article_category.destroy
      redirect_to article_categories_url, success: 'Article category was successfully destroyed.'
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_article_category
        @article_category = ArticleCategory.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def article_category_params
        params.require(:article_category).permit(:name)
      end
  end
end
