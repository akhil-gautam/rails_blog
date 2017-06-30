class ArticlesController < ApplicationController

	before_action :authenticate_user!, :except => [:index]
	before_action :belongs_to_user, :only => [:destroy, :update]
	

	def index

		if params[:query].present?
			@articles = Article.search(params[:query]).paginate(:page => params[:page])
			render 'search'
		else
    		@articles = Article.all.paginate(:page => params[:page], :per_page => 5).order('created_at DESC')
    	end
  	end
 

	def show	
		@article = Article.find(params[:id])
		render layout: "show_layout"
		
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
	    @article.destroy
	    redirect_to articles_path
 	end

	private
  		def article_params
    		params.require(:article).permit(:title, :article)
  		end

		def belongs_to_user
			@article = Article.find_by_id(params[:id])
			unless can? :destroy, @article
				flash[:alert] = "Sorry! You are un-authorized to do this!"
				redirect_to articles_path
			end
		end

end  	