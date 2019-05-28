require 'faker'

RecipeItem.destroy_all
Recipe.destroy_all
Ingredient.destroy_all
User.destroy_all

nic = User.create(
  email: 'nic@gmail.com',
  password: '1'
)

units_of_measure = ['mL', '', 'g', 'oz', 'L']

ingredients = []
40.times do
  ingredient = Ingredient.new(name: Faker::Food.ingredient)
  ingredient.unit_of_measure = units_of_measure.sample
  ingredient.save
  ingredients << ingredient
end

10.times do
  recipe = Recipe.new(
    name: Faker::Food.dish,
    prep_time: rand(20),
    cook_time: rand(30),
    servings: rand(4),
    steps: "cut,slice,boil,and cook",
    rating: rand(5),
    photo: "url",
    difficulty: "easy"
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
  p recipe
end


15.times do
  item = GroceryItem.new(quantity: rand(10))
  item.user = nic
  item.ingredient = ingredients.sample
  item.save unless GroceryItem.where(user: nic).find_by(ingredient_id: item.ingredient.id)
end

10.times do
  item = FridgeItem.new(quantity: rand(10))
  item.user = nic
  item.ingredient = ingredients.sample
  item.save
end
