class CookingListItem < ApplicationRecord
  belongs_to :cooking_list
  belongs_to :recipe
end
