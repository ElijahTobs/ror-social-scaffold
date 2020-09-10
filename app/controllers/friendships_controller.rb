class FriendshipsController < ApplicationController
  def new
    @friendship = Friendship.new
  end

  def create
    @friendship_request = Friendship.new(params[:friendship_request])
    if @friendship_request.save
      flash[:success] = "Friendship successfully created"
      redirect_to users_path
    else
      flash[:error] = "Something went wrong"
    end
  end
  
  
end
