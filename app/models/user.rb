class User < ApplicationRecord
<<<<<<< HEAD
  has_many :recipes
  has_many :grocery_list_items
  has_many :fridge_items
  has_many :cooking_list_items
=======
  has_one :fridge, dependent: :destroy
  has_one :grocery_list, dependent: :destroy
  has_one :cooking_list, dependent: :destroy
  has_many :recipes, dependent: :destroy
>>>>>>> master

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
