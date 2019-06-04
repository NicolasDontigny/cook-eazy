class User < ApplicationRecord
  mount_uploader :avatar, AvatarUploader

  has_many :recipes
  has_many :grocery_items
  has_many :fridge_items
  has_many :wishlist_items
  has_many :reviews, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  def email_required?
    false
  end
end
