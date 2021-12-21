class Post < ApplicationRecord
  belongs_to :user
  attachment :image
  has_many :likes, dependent: :destroy
end
