class FriendshipsController < ApplicationController
  def send_request
    if current_user.send_invite(params[:user_id])
      flash[:notice] = "Friend request sent"
      redirect_to users_path
    else
      flash[:error] = "Unable to send friend request"
    end
  end

  def accept_request
    if current_user.confirm_friend(params[:user_id])
      flash[:success] = "You're now friends with #{@user.name}"
      redirect_to users_path
    else
      flash[:error] = "Something went wrong"
    end
  end
  
  def reject_request
    if current_user.reject_friend(params[:user_id])
      flash[:success] = 'Friend request rejected.'
      redirect_to users_path
    else
      flash[:error] = 'Something went wrong'
    end
  end

  def pending_request
    @pending_request = current_user.pending_friends
  end
  
  private

  def friendship_params
    params.permit(:id, :user_id, :friend_id, :status)
  end
  
end
