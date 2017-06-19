class UsersController < ApplicationController

	def new
		user = User.new
	end

	def create
		@user = User.new(params[:id])
		if @user.save
			flash[:alert] = "Welcome! You have signed In."
			redirect_to articles_path
		else
			render 'new'
		end
	end

	def show
		if sign_out(@user)
			flash[:alert] = "Thank you! You have signed out."
			redirect_to articles_path;
		end
	end

end
