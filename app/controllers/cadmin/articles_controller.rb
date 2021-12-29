require_dependency "cadmin/application_controller"

module Cadmin
  class ArticlesController < ApplicationController
    before_action :set_article, only: [:show, :edit,:update, :destroy]
    
    add_breadcrumb 'Articulos', :articles_path

    # GET /articles
    def index      
      @articles = Article.all
      # articles = @articles.filter_by_search(params['title']) if params['title'].present?

      # @pagy,@articles= pagy(articles, items: 5)

      params[:tag] ? @article = Article.tagged_with(params[:tag]) : @articles = Article.all
    end
    
    # GET /articles/1
    def show
      add_breadcrumb @article.title
      @articles = Article.order(created_at: 'DESC').all
      @categories = ArticleCategory.all
      @tags = Article.tag_counts

      # TODO: search results
      articles = articles.filter_by_search(params['title']) if params['title'].present?
      # TODO: COMPLETAR COMENTARIOS ASOCIADOS A ARTICULOS
      comments = @article.comments.all     
    end

    # GET /articles/new
    def new
      add_breadcrumb 'Nuevo artículo'
      @article = Article.new
    end

    # GET /articles/1/edit
    def edit
      add_breadcrumb 'Editar artículo'
    end

    # POST /articles
    def create
      @article = Article.create(article_params)

      if @article.save
        redirect_to  @article,success: t('.success')
      else
        render :new
      end
    end

    # PATCH/PUT /articles/1
    def update
      if @article.update(article_params)
        redirect_to @article, success: t('.success')
      else
        render :edit
      end
    end

    # DELETE /articles/1
    def destroy
      @article.destroy
      redirect_to articles_url, success: t('.success')
    end

    # todo: set status
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_article
        @article = Article.friendly.find(params[:id])
      end
      
      # Only allow a list of trusted parameters through.
      def article_params
        params.require(:article).permit(:title, :content,:status,:published_at,:unpublished_at,:metatitle,:metadata, :user_id,:article_category_id,:tag_list, :tag,:image, tag_ids: [])
      end
  end
end
