class FriendshipsController < ApplicationController
  def send_invitation
    if current_user.send_invitation(params[:user_id])
      flash.notice = 'Friend invitation sent'
      redirect_to users_path
    else
      flash.now[:notice] = 'error occured'
    end
  end

  def accept_invitation
    if current_user.confirm_invites(params[:user_id])
      flash.notice = 'Friend request accepted'
      redirect_to users_path
    else
      flash.now[:notice] = 'error occured'
    end
  end

  def reject_invitation
    if current_user.reject_invites(params[:user_id])
      flash.notice = 'Friend request declined'
      redirect_to users_path
    else
      flash.now[:notice] = 'error occurd'
    end
  end

  def pending_invitation
    @pending_invitations = current_user.pending_invites
  end

  def destroy
    f1 = Friendship.all.find_by(user_id: params[:user_id], friend_id: current_user.id)
    f2 = Friendship.all.find_by(user_id: current_user.id, friend_id: params[:user_id])
    f1&.delete
    f2&.delete
    redirect_to users_path
  end

  def friends_list
    @friends_list = current_user.friends
  end
end
