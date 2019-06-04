puts 'cleaning db'
RecipeItem.destroy_all
GroceryItem.destroy_all
Recipe.destroy_all
Ingredient.destroy_all
User.destroy_all
FridgeItem.destroy_all

puts 'creating user'

nic = User.create(
  username: 'duck',
  password: '1'
)

puts 'call to API'

response = JSON.parse(open("https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/random?number=10&tags=vegan", {
  "X-RapidAPI-Host" => "spoonacular-recipe-food-nutrition-v1.p.rapidapi.com",
  "X-RapidAPI-Key" => ENV['X_RapidAPI_Key']
}).read)

puts 'storing parsed json in recipes'

recipes = response['recipes']


recipes.each do |recipe|

  puts 'creating recipes'

  new_recipe = Recipe.new(
            name: recipe["title"],
            prep_time: recipe["preparationMinutes"] || 5,
            cook_time: recipe["cookingMinutes"] || 5,
            servings: recipe["servings"],
            photo: recipe["image"] || 'https://source.unsplash.com/1600x900/?vegan',
            difficulty: ["Easy", "Moderate", "Hard"].sample)

  recipe["extendedIngredients"].each do |do_ingredient|
    new_recipe.recipe_items << RecipeItem.new(
      quantity: do_ingredient["measures"]["metric"]["amount"].ceil,
      ingredient: Ingredient.find_or_create_by(name: do_ingredient["name"], unit_of_measure: do_ingredient["measures"]["metric"]["unitShort"], category: do_ingredient["aisle"].split(';').first)
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
first_recipe_7_recipe_items = first_recipe.recipe_items.take(7)
puts 'storing first recipe first 7 ingredients in Nic\'s fridge'
first_recipe_7_recipe_items.each do |recipe_item|
  fitem = FridgeItem.new(
    ingredient: recipe_item.ingredient,
    quantity: recipe_item.quantity,
    user: nic
    )
  fitem.save!
end

puts 'storing second recipe in a variable'
second_recipe = Recipe.second
puts 'getting second recipe first 7 ingredients'
second_recipe_7_recipe_items = second_recipe.recipe_items.take(7)
puts 'storing second recipe first 7 ingredients in Nic\'s fridge'
second_recipe_7_recipe_items.each do |recipe_item|
  fitem = FridgeItem.new(
    ingredient: recipe_item.ingredient,
    quantity: recipe_item.quantity,
    user: nic
    )
  fitem.save!
end

puts 'creating grocery items'
gitem = GroceryItem.new(
    ingredient: Ingredient.first,
    user: nic,
    quantity: 1
    )
gitem.save!

puts 'Creating reviews'
reviews = ["Super good, would not order again.", "What is this, this is so good!", "Gave me diarhea, I would love to eat more!", "This is the best vegan recipe I ever had!", "Vegan 4lyfe", "Drake approved!", "Martin loved it but still fell asleep while eating"]

puts 'getting 5 recipes'
fiverecipes = Recipe.all.sample(5)

puts 'adding reviews to the recipes'
fiverecipes.each do |recipe|
  3.times do
    new_review = Review.new(
      content: reviews.sample,
      rating: rand(1..4)
      )
    new_review.recipe = recipe
    new_review.user = nic
    new_review.date = DateTime.now
    new_review.save!
  end
end

puts 'Done baby!'
