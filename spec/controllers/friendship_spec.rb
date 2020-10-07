require 'rails_helper'
RSpec.describe FriendshipsController, type: :controller do
  include Devise::Test::ControllerHelpers
  before(:each) do
    @user = FactoryBot.create(:user)
    @friend = FactoryBot.create(:user, name: 'Elijah', email: 'eli@jah.com')
    sign_in @user
  end

  describe 'friendship features ' do
<<<<<<< HEAD
    it 'send friend request' do
=======
    it 'creates a friend request' do
>>>>>>> 52728c63df2a82fe5099b7b659f67ed4a2a84468
      post :send_invitation, params: { user_id: @friend.id }
      expect(response).to redirect_to(users_path)
      expect(response).to have_http_status(302)
    end

<<<<<<< HEAD
    it 'accepts friend request' do
=======
    it 'accepts a friend request' do
>>>>>>> 52728c63df2a82fe5099b7b659f67ed4a2a84468
      post :send_invitation, params: { user_id: @friend.id }
      sign_out @user
      sign_in @friend
      post :accept_invitation, params: { user_id: @user.id }
      expect(response).to redirect_to(users_path)
      expect(response).to have_http_status(302)
    end

    it 'rejects friend request' do
      post :send_invitation, params: { user_id: @friend.id }
      sign_out @user
      sign_in @friend
      post :reject_invitation, params: { user_id: @user.id }
      expect(response).to redirect_to(users_path)
      expect(response).to have_http_status(302)
    end
  end
end