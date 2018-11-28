class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :tweets, dependent: :destroy
  has_many :follower_relationships,  class_name:   "Relationship",
           foreign_key:  "follower_id",
           dependent:    :destroy
  has_many :followed_relationships, class_name:  "Relationship",
           foreign_key: "followed_id",
           dependent:   :destroy

  has_many :following, through: :follower_relationships, source: :followed
  has_many :followers, through: :followed_relationships, source: :follower
  def feed
    following_ids = "SELECT followed_id FROM relationships
                     WHERE  follower_id = :user_id"
    Tweet.where("user_id IN (#{following_ids})
                     OR user_id = :user_id", user_id: id)
  end
  def follow(other_user)
    follower_relationships.create(followed_id: other_user.id)
  end

  def unfollow(other_user)
    follower_relationships.find_by(followed_id: other_user.id).destroy
  end

  def following?(other_user)
    following.include?(other_user)
  end
end
