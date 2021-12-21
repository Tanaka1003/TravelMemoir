class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable

  has_many :posts, dependent: :destroy
  attachment :profile_image
  has_many :likes, dependent: :destroy

  def already_liked?(post)
    self.likes.exists?(post_id: post.id)
  end
end
