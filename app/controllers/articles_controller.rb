class ArticlesController < ApplicationController

	before_action :validate_user, :only => [:show, :edit]

	def index
    	@articles = Article.all
  	end

	def show
		@article = Article.find(params[:id])
	end

	def new
		if user_signed_in?
			@article = current_user.articles.build
		else
			flash[:alert] = "Please Sign-In to write an article!"
			redirect_to '/users/sign_in'
		end
	end

	def edit
		@article = Article.find_by_id(params[:id])
		unless can? :update, @article
			flash[:notice] = "Sorry! You are not authorized to edit this article!"
			redirect_to articles_path
		end
	end

	def create
  		@article = current_user.articles.build(article_params)
  		if @article.save
  			flash[:notice] = "Article successfully created!"
    		redirect_to(@article)
  		else
    		render 'new'
  		end
	end
	def update
  		@article = Article.find(params[:id])
 
  		if @article.update(article_params)
    		redirect_to @article
  		else
    		render 'edit'
  		end
	end

	def destroy
		@article = Article.find(params[:id])
		unless can? :destroy, @article
			flash[:notice] = "Sorry! You are not authorized to delete this article!"
			redirect_to articles_path
		else
	    	@article.destroy
	    	redirect_to articles_path
	    end
 	end

	private
  		def article_params
    		params.require(:article).permit(:title, :article)
  		end

  		def validate_user
  			begin
  				@article = Article.find(params[:id])
  			rescue
  				flash[:alert] = "Sorry! The article doesn't exist."
  				redirect_to articles_path
  			end
  		end
end
