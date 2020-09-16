class FriendshipsController < ApplicationController
  def send_request
    if current_user.send_request(params[:user_id])
      flash[:notice] = "Friend request sent"
      redirect_to users_path
    else
      flash[:error] = "Unable to send friend request"
    end
  end

  def update
    @user = User.find(friend_id: params[:user_id])

    if current_user.confirm_friend(@user, method: :put)
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
  
  private

  def friendship_params
    params.permit(:id, :user_id, :friend_id, :status)
  end
  
end
