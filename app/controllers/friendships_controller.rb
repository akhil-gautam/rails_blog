class FriendshipsController < ApplicationController


  def index
    #@users = User.all.reject{ |user| current_user.friendships.pluck(:friend_id).include?(user.id)}
    @users = User.where.not(id: (current_user.friends.pluck(:friend_id) << current_user.id))
  end

  def show
  end

  def create
    friendship = current_user.friendships.build(:friend_id => params[:friend_id])
    @friend_removal = params[:friend_id]
    inverse_friendship = User.find_by_id(params[:friend_id]).friendships.build(:friend_id => current_user.id)
    
    if friendship.save && inverse_friendship.save
      respond_to do |format|
        format.html
        format.js {flash.now[:alert] = "Added Friend Successfully!"}  
        
      end
    else
      flash[:error] = "Error occurred when adding friend!"
      redirect_to root_url
    end
  end
  
  def destroy
	
    friendship = current_user.friendships.find(params[:id])
    @friendship_removal = params[:id]
    inverse_friendship = Friendship.find_by(user_id: friendship.friend_id, friend_id: current_user.id)
    friendship.destroy
    inverse_friendship.destroy
     respond_to do |format|
        format.html
        format.js {  flash.now[:notice] = "Friend Removed successfully" }
      end 
  end
end
