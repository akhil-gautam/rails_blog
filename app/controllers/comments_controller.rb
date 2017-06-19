class CommentsController < ApplicationController
    
  def create
    @article = Article.find(params[:article_id])
    if user_signed_in?
      @comment = @article.comments.create(params[:comment].permit(:name, :body))
      redirect_to article_path(@article)
    else
      flash[:notice] = "Please Sign In to comment!"
      redirect_to '/users/sign_in'
    end
  end
  
  def destroy
    if user_signed_in?
      @article = Article.find(params[:article_id])
      @comment = @article.comments.find(params[:id])
      @comment.destroy
      redirect_to article_path(@article)
    else
      flash[:alert] = "Please Sign-In to delete!"
      redirect_to '/users/sign_in'
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:name, :body)
    end
end
