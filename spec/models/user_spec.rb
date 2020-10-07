require 'rails_helper'
RSpec.describe User, type: :model do

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_most(20) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive }

    let(:wrong) { 'test@test' }
    it { should_not allow_value(:wrong).for(:email) }

    it { should allow_value('test@test.com').for(:email) }
  end
  describe 'associations' do
    it { should have_many(:posts) }
    it { should have_many(:comments) }
    it { should have_many(:likes) }
    it { should have_many(:friendships) }
    it { should have_many(:inverse_friendships).class_name('Friendship').with_foreign_key(:friend_id) }
  end

  describe 'class methods' do
    before(:each) do
      @user1 = FactoryBot.create(:user, name: 'Elijah', email: 'elijah@mail.com')
      @user2 = FactoryBot.create(:user, name: 'Mayokun', email: 'mayokun@mail.com')
      @friend = FactoryBot.create(:user, name: 'Modalayo', email: 'modalayo@mail.com')
      @friend_request1 = FactoryBot.create(:friendship, user_id: @user1.id, friend_id: @friend.id, confirmed: false)
      @friend_request2 = FactoryBot.create(:friendship, user_id: @user2.id, friend_id: @friend.id, confirmed: true)
    end

    it 'checks if friend sending invitaion' do
      expect(@user2.send_invitation(@friend.id)).to eql(true)
      expect(@friend_request1.confirmed).to eql(false)
    end

    it 'checks for pending invitaion' do
      @user1.send_invitation(@friend.id)
      expect(@user1.pending_invites).to include(@friend)
      expect(@friend_request1.confirmed).not_to eql(true)
    end

    it 'checks for pending friends' do
      @friend.send_invitation(@user1.id)
      expect(@user1.pending_friends).to include(@friend)
    end
  end
end