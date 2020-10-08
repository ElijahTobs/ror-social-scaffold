require 'rails_helper'
RSpec.describe FriendshipsController, type: :controller do
  include Devise::Test::ControllerHelpers
  before(:each) do
    @user = FactoryBot.create(:user)
    @friend = FactoryBot.create(:user, name: 'Elijah', email: 'eli@jah.com')
    sign_in @user
  end

  describe 'friendship features ' do
    it 'send friend request' do
      post :send_invitation, params: { user_id: @friend.id }
      expect(response).to redirect_to(users_path)
      expect(response).to have_http_status(302)
    end

    it 'accepts friend request' do
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
