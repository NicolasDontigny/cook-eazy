require 'faker'

RecipeItem.destroy_all
Recipe.destroy_all
Ingredient.destroy_all
User.destroy_all

nic = User.create(
  email: 'nic@gmail.com',
  password: '123456'
)

ingredients = []
40.times do
  ingredient = Ingredient.create(name: Faker::Food.ingredient)
  ingredients << ingredient
end

10.times do
  recipe = Recipe.new(
    name: Faker::Food.dish
  )

  recipe.user = nic
  recipe.save


  4.times do
    recipe_item = RecipeItem.new()
    recipe_item.recipe = recipe
    recipe_item.ingredient = ingredients.sample
    recipe_item.save
    p recipe_item
  end
end
