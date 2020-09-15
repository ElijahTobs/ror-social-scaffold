class FriendshipsController < ApplicationController
  def new
    @friendship = Friendship.new
  end
  
  def create
    @friendship_request = current_user.friendships.new(friend_id: params[:user_id], confirmed: false)

    if @friendship_request.save
      flash[:notice] = "Friend request sent"
      redirect_to users_path
    else
      flash[:error] = "Unable to send friend request"
    end
  end

  def update
    @friendship = current_user.friendships.find(id: params[:id])
    if @friendship.update(status: true)
      flash[:success] = "You're now friends with #{@user.name}"
      redirect_to users_path
    else
      flash[:error] = "Something went wrong"
    end
  end
  
  def destroy
    @friendshp = current_user.friendships.find(params[:id])
    if @friendshp.destroy
      flash[:success] = 'Friend request rejected.'
      redirect_to users_path
    else
      flash[:error] = 'Something went wrong'
    end
  end
  
  
end
