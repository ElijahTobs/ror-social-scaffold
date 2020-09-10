class FriendshipsController < ApplicationController
  def new
    @friendship = Friendship.new
  end

  def create
    @friendship_request = current_user.Friendship.new(id: params[:id], user_id: params[user_id:], friend_id:, status: false)
    if @friendship_request.save
      flash[:success] = "Friend request sent"
      redirect_to users_path
    else
      flash[:error] = "Unable to send friend request"
    end
  end

  def update
    @friendship = current_user.Friendship.find(id: params[:id])
    if @friendship.update(status: true)
      flash[:success] = "You're now friends with #{@user.name}"
      redirect_to users_path
    else
      flash[:error] = "Something went wrong"
    end
  end
  
  def destroy
    @friendshp = current_user.Friendship.find(params[:id])
    if @friendshp.destroy
      flash[:success] = 'Friend request rejected.'
      redirect_to users_path
    else
      flash[:error] = 'Something went wrong'
    end
  end
  
  
end
