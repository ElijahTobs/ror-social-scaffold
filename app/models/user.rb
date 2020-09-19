class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :friendships
  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: 'friend_id'

  def friends
    friends_array = friendships.map { |friendship| friendship.friend if friendship.confirmed }
    friends_arrayb = inverse_friendships.map { |friendship| friendship.user if friendship.confirmed }
    friends_array.concat(friends_arrayb)
    friends_array.compact
  end

  def pending_invites
    friendships.map { |friendship| friendship.friend unless friendship.confirmed }.compact
  end

  def pending_friends
    inverse_friendships.map { |friendship| friendship.user unless friendship.confirmed }.compact
  end

  def friend_invites(user_id)
    friendship = friendships.find_by(friend_id: user_id)
    true if friendship && friendship.confirmed == false
  end

  def receive_invitation(user_id)
    friendship = inverse_friendships.find_by(user_id: user_id)
    true if friendship && friendship.confirmed == false
  end

  def send_invitation(user_id)
    @friendship = Friendship.new(user_id: id, friend_id: user_id)
    @friendship.confirmed = false
    @friendship.save
  end

  def confirm_invites(user_id)
    friendship = inverse_friendships.find_by(user_id: user_id)
    friendship.confirmed = true
    friendship.save
  end

  def reject_invites(user)
    friendship = inverse_friendships.find_by(user_id: user)
    friendship.destroy
  end

  def friend?(user)
    friends.include?(user)
  end
end