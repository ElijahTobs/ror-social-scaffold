require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  include Devise::Test::ControllerHelpers
  before(:each) do
    @user = FactoryBot.create(:user)
    sign_in @user
  end

  describe 'GET #index' do
    it 'gets all the user posts and render index page' do
      get :index
      expect(response).to be_successful
      expect(response).to render_template(:index)
    end
  end

  describe 'POST #create' do
    context 'valid params' do
      it 'creates a new post' do
        post :create, params: { post: { content: 'Sample post', user_id: @user.id } }
        expect(response).to redirect_to(posts_path)
      end
    end

    context 'invalid params' do
      it 'redirects to index page with invalid params' do
        post :create, params: { post: { content: 1234 } }
        get :index
        expect(response).to render_template(:index)
      end
    end
  end
end