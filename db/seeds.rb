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

big_step = "Eleifend ad dolor lorem habitant. Praesent lacus taciti, mollis aptent. Justo consectetur magnis ad cubilia ante mi consequat dolor turpis eleifend! Conubia, inceptos a condimentum tristique? Fringilla egestas tellus quam dui magnis a mus montes natoque? Torquent class eget porttitor maecenas cras ante. Dictum sociosqu eget euismod! Porta mollis ante ultricies enim orci adipiscing. Viverra ligula ante aptent nec viverra suspendisse; habitasse ultrices. Ridiculus bibendum eget, bibendum fringilla congue vivamus. Rutrum sollicitudin pulvinar eu elit. "

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
    prep_time: rand(80),
    cook_time: rand(80),
    servings: rand(4),
    rating: rand(5),
    photo: "https://source.unsplash.com/collection/251966/1600x900",
    difficulty: ["Easy", "Moderate", "Hard"].sample
  )

  recipe.user = nic
  recipe.save

  step = Step.new(content: big_step, order: 1)
  step.recipe = recipe
  step.save

  step = Step.new(content: big_step, order: 2)
  step.recipe = recipe
  step.save

  step = Step.new(content: big_step, order: 3)
  step.recipe = recipe
  step.save




  7.times do
    recipe_item = RecipeItem.new(quantity: rand(15) + 1)
    recipe_item.recipe = recipe
    recipe_item.ingredient = ingredients.sample
    recipe_item.save unless RecipeItem.where(recipe: recipe).find_by(ingredient_id: recipe_item.ingredient.id)
  end
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
