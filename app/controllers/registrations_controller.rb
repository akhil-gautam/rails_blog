class RegistrationsController < Devise::RegistrationsController

	def sign_up_params
		params.require(:user).permit(:name, :email, :avatar, :password, :password_cofirmation)
	end

	def account_update_params
		params.require(:user).permit(:name, :email, :avatar, :password, :password_cofirmation, :current_password, :about)
	end

end