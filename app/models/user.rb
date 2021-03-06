class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable

  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_many :relationships, dependent: :destroy
  has_many :followings, through: :relationships, source: :follow

  has_many :passive_relationships, class_name: 'Relationship', foreign_key: 'follow_id', dependent: :destroy
  has_many :followers, through: :passive_relationships, source: :user

  validates :name, length: { minimum: 2 }, presence: true, uniqueness: true
  validates :age, presence: true
  validates :address, presence: true

  def already_liked?(post)
    likes.exists?(post_id: post.id)
  end

  def follow(other_user)
    return if self == other_user
    relationships.find_or_create_by!(follow: other_user)
  end

  def unfollow(relationship_id)
    relationships.find(relationship_id).destroy!
  end

  def following?(user)
    followings.include?(user)
  end
end
