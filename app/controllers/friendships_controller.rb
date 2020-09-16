class FriendshipsController < ApplicationController
  # def new
  #   @friendship = Friendship.new
  # end
  
  # accept_params = { id: friend[0], user_id: current_user.id, friend_id: id, status: true }

  # def index
  #   @friendship = Friendship.all
  #   @friendship
  # end

  def create
    # @request_sender = User.find(params[:user_id])
    @friendship = Friendship.new(friendship_params)

    # user_id: current_user.id, friend_id: @request_sender.id, confirmed: false

    if @friendship.save
      flash[:notice] = "Friend request sent"
      redirect_to users_path
    else
      flash[:error] = "Unable to send friend request"
    end
  end

  def update
    # @request_sender = User.find(params[:user_id])
    # @friendship = Friendship.find(params[:id])
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
