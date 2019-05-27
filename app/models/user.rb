class User < ApplicationRecord
  has_one :fridge, dependent: :destroy
  has_one :grocery_list, dependent: :destroy
  has_one :cooking_list, dependent: :destroy
  has_many :recipes, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
