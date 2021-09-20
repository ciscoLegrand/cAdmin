require_dependency "cadmin/application_controller"

module Cadmin
  class CommentsController < ApplicationController
    before_action :set_comment, only: [:show, :edit, :update, :destroy]

    # GET /comments
    def index
      comments = Comment.all


      @pagy, @comments = pagy(comments, items: 5)  
    end

    # GET /comments/1
    def show
    end

    # GET /comments/new
    def new
      @comment = Comment.build
    end

    # GET /comments/1/edit
    def edit
    end

    # POST /comments
    def create
      @article = Article.find(params[:article_id])
      @comment = @article.comments.build(comment_params)
      
      if @comment.save
        redirect_to @article, notice: 'Comment was successfully created.'
      else
        render :new
      end
    end

    # PATCH/PUT /comments/1
    def update
      if @comment.update(comment_params)
        redirect_to @article, notice: 'Comment was successfully updated.'
      else
        render :edit
      end
    end

    # DELETE /comments/1
    def destroy
      @article = Article.find(params[:article_id])
      @comment = @article.comments.find(params[:id])
      @comment.destroy
      redirect_to root_path notice: 'Comment was successfully destroyed.'
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_comment
        @comment = Comment.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def comment_params
        params.require(:comment).permit(:content, :user_id, :article_id)
      end
  end
end
