puts 'cleaning db'
RecipeItem.destroy_all
GroceryItem.destroy_all
Recipe.destroy_all
Ingredient.destroy_all
User.destroy_all
FridgeItem.destroy_all

puts 'creating user'

nic = User.create(
  email: 'nic@gmail.com',
  password: '1'
)

puts 'call to API'

response = JSON.parse(open("https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/random?number=10&tags=vegan", {
  "X-RapidAPI-Host" => "spoonacular-recipe-food-nutrition-v1.p.rapidapi.com",
  "X-RapidAPI-Key" => "5d617a7d56msh634d28d65593c67p1f58d8jsn619c46a15563"
}).read)

puts 'storing parsed json in recipes'

recipes = response['recipes']


recipes.each do |recipe|

  puts 'creating ingredients'

  # ingredients = recipe["extendedIngredients"].each do |ingredient|
  #   ingredient = Ingredient.new (
  #     name: ingredient["name"],
  #     unit_of_measure: ingredient["unit"]
  #   )
  #   ingredient.save!
  # end


  puts 'creating recipes'

  new_recipe = Recipe.new(
            name: recipe["title"],
            prep_time: recipe["preparationMinutes"] || 0,
            cook_time: recipe["cookingMinutes"] || 0,
            servings: recipe["servings"],
            photo: recipe["image"],
            difficulty: ["Easy", "Moderate", "Hard"].sample)

  recipe["extendedIngredients"].each do |do_ingredient|
    new_recipe.recipe_items << RecipeItem.new(
      quantity: do_ingredient["amount"],
      ingredient: Ingredient.find_or_create_by(name: do_ingredient["name"])
    )
  end

  recipe["analyzedInstructions"][0]["steps"].each do |step|
    new_recipe.steps << Step.new(
      content: step["step"],
      order: step["number"]
    )
  end

  puts 'saving recipe user'
  new_recipe.user = nic

  puts 'saving recipe'
  new_recipe.save!

  puts 'Done creating recipes, steps and ingredients'
end

puts 'storing first recipe in a variable'
first_recipe = Recipe.first
puts 'getting first recipe first 7 ingredients'
first_recipe_7_ingredients = first_recipe.ingredients.take(7)
puts 'storing first recipe first 7 ingredients in Nic\'s fridge'
first_recipe_7_ingredients.each do |ingredient|
  fitem = FridgeItem.new(
    ingredient: ingredient,
    user: nic
    )
  fitem.save!
end

puts 'storing second recipe in a variable'
second_recipe = Recipe.second
puts 'getting second recipe first 7 ingredients'
second_recipe_7_ingredients = second_recipe.ingredients.take(7)
puts 'storing second recipe first 7 ingredients in Nic\'s fridge'
second_recipe_7_ingredients.each do |ingredient|
  fitem = FridgeItem.new(
    ingredient: ingredient,
    user: nic
    )
  fitem.save!
end


puts 'getting first recipe last ingredient'
first_recipe_last_ingredient = first_recipe.ingredients.last
puts 'storing first recipe last ingredient in Nic\'s grocery list'
gitem = GroceryItem.new(
    ingredient: first_recipe_last_ingredient,
    user: nic,
    quantity: 1
    )
gitem.save!

puts 'getting second recipe last ingredient'
second_recipe_last_ingredient = second_recipe.ingredients.last
puts 'storing second recipe last ingredient in Nic\'s grocery list'
gitem = GroceryItem.new(
    ingredient: second_recipe_last_ingredient,
    user: nic,
    quantity: 1
    )
gitem.save!
