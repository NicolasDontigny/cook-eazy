class User < ApplicationRecord
  has_many :recipes
  has_many :grocery_list_items
  has_many :fridge_items
  has_many :cooking_list_items

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
