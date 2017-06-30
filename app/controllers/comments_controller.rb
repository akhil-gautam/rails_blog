class CommentsController < ApplicationController

  before_action :belongs_to_user, :only => [:destroy]
    
  def create
    @article = Article.find(params[:article_id])

    if user_signed_in?
      @comment = @article.comments.create(comment_params)
      @comment.user_id = current_user.id
      if @comment.save
        respond_to do |format|
          format.html 
          format.js
        end 
      end

    else
      flash[:notice] = "Please Sign In to comment!"
      redirect_to '/users/sign_in'
    end
  end
  
  def destroy
      @article = Article.find(params[:article_id])
      @comment = @article.comments.find(params[:id])
      @comment.destroy
      redirect_to article_path(@article)
  end

  private
    def comment_params
      params.require(:comment).permit(:body)
    end

    def belongs_to_user
      @article = Article.find(params[:article_id])
      @comment = @article.comments.find(params[:id])
      unless can? :destroy, @comment
        flash[:alert] = "Un-authorized to delete!!"
        redirect_to root_path
      end
    end
end
