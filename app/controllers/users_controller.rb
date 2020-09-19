class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
    @pending_invitations = current_user.pending_friends
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.ordered_by_most_recent
    @friend_request = current_user.friend_requests.build
  end
end
