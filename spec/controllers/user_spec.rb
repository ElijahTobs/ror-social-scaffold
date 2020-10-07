require 'rails_helper'
RSpec.describe UsersController, type: :controller do
  include Devise::Test::ControllerHelpers
  before(:each) do
    @user = FactoryBot.create(:user)
    sign_in @user
  end

  describe 'GET #index' do
    it 'gets all the users and render index page' do
      get :index
      expect(response).to be_successful
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #show' do
    it 'gives the user show page' do
      get :show, params: { id: @user.id }
      expect(response).to be_successful
      expect(response).to render_template(:show)
    end
  end
end
