class Post < ApplicationRecord
  belongs_to :user
  attachment :image
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
end
