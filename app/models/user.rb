class User < ApplicationRecord
  has_one :fridge
  has_one :grocery_list
  has_one :cooking_list
  has_many :recipes

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
