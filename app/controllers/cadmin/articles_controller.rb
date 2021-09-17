require_dependency "cadmin/application_controller"

module Cadmin
  class ArticlesController < ApplicationController
    before_action :set_article, only: [:show, :edit, :update, :destroy]
    add_breadcrumb 'Articulos'
    # GET /articles
    def index
      @articles = Article.all
    end

    # GET /articles/1
    def show
      add_breadcrumb @article.title
      @articles = Article.order(created_at: 'DESC').all
      # TODO: COMPLETAR COMENTARIOS ASOCIADOS A ARTICULOS
    end

    # GET /articles/new
    def new
      @article = Article.new
    end

    # GET /articles/1/edit
    def edit
    end

    # POST /articles
    def create
      @article = Article.new(article_params)

      if @article.save
        redirect_to @article, notice: 'Article was successfully created.'
      else
        render :new
      end
    end

    # PATCH/PUT /articles/1
    def update
      if @article.update(article_params)
        redirect_to @article, notice: 'Article was successfully updated.'
      else
        render :edit
      end
    end

    # DELETE /articles/1
    def destroy
      @article.destroy
      redirect_to articles_url, notice: 'Article was successfully destroyed.'
    end

    def unpublish
      # TODO: set a date to unpublish article, this article will be hidden when the date arrives 
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_article
        @article = Article.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def article_params
        params.require(:article).permit(:title, :content,:status,:published_at,:unpublished_at,:metatitle,:metadata, :user_id,:image)
      end
  end
end
