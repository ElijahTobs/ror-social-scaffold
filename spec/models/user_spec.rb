require 'rails_helper'
RSpec.describe User, type: :model do

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_length_of(:name).is_at_most(20) }
    it { is_expected.to validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive }

    # let(:wrong) { 'test@test' }
    # it { should_not allow_value(:wrong).for(:email) }

    # it { should allow_value('test@test.com').for(:email) }

    context 'when email has wrong format' do
      let(:wrong_email1) { 'jan@foo' }
  
      it 'complains for invalid format' do
        # is_expected.to eq false
        should_not allow_value(:wrong_email1).for(:email)
      end
  
      let(:wrong_email2) { 'jan' }
  
      it 'complains for invalid format' do
        # is_expected.to eq false
        should_not allow_value(':wrong_email2').for(:email)
      end
    end
  
    context 'when email has correct format' do
      it 'accepts valid format' do
        is_expected.to allow_value('good@mail.com').for(:email)
        # should allow_value(:correct_email).for(:email)
      end
    end

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

    it 'checks for confirming invitaion' do
      @friend.send_invitation(@user2.id)
      expect(@friend.confirm_invites(@user2.id)).to be(true)
      expect(@friend_request2.confirmed).to eql(true)
    end

    it 'checks for rejecting invitaion' do
      @user1.send_invitation(@friend.id)
      @friend.reject_invites(@user1.id)
      expect(@user1.friends).not_to include(@friend)
    end

    it 'confirms if a user is a friend' do
      @user1.send_invitation(@friend.id)
      @user2.send_invitation(@friend.id)
      expect(@user1.friend?(@friend)).to be(false)
      expect(@user2.friend?(@friend)).to be(true)
    end
  end
end