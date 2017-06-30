class Provider < ActiveRecord::Base
	belongs_to :user

	  	def self.create_provider_with_omniauth(auth)
	    	create(:uid => auth.uid, :provider => auth.provider)
	  	end
end
