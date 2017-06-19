class CallbacksController < Devise::OmniauthCallbacksController
	
    def facebook
        auth = request.env["omniauth.auth"]
        @user = User.find_by_email(auth.info.email)
        if @user.nil?
            @user = User.create_user_with_omniauth(auth)
            @provider = @user.providers.create_provider_with_omniauth(auth)
        else
            @provider = @user.providers.find_by(:provider => auth.provider)
            if @provider
                @provider.update_attributes(:uid => auth.uid)
            else
                @provider = @user.providers.create(:provider => auth.provider, :uid => auth.uid)
            end
        end
        sign_in_and_redirect @user
    end
    def twitter
        auth = request.env["omniauth.auth"]
        @user = User.find_by_email(auth.info.email)
        if @user.nil?
    		@user = User.create_user_with_omniauth(auth)
            @provider = @user.providers.create_provider_with_omniauth(auth)
    	else
    		@provider = @user.providers.find_by(:provider => auth.provider)
    		if @provider
    			@provider.update_attributes(:uid => auth.uid)
    		else
    			@provider = @user.providers.create(:provider => auth.provider, :uid => auth.uid)
    		end
    	end
        sign_in_and_redirect @user
    end
end