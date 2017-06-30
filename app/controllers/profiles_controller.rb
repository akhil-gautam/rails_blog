class ProfilesController < ApplicationController

	def index
    	#@users = User.all.reject{ |user| current_user.friendships.pluck(:friend_id).include?(user.id)}
    	@users = User.where.not(id: (current_user.friends.pluck(:friend_id) << current_user.id))
  	end
  
  	def show
    	
  	end
end
