Rails.application.routes.draw do
  get 'reviews/create'
  devise_for :users
  root to: 'pages#landing'

  # Recipes Routes
  get 'recipes' => 'recipes#index', as: :recipes
  get 'recipes/:id' => 'recipes#show', as: :recipe
  get 'recipes/:recipe_id/add-to-grocery' => 'grocery_items#add', as: :add_grocery_items
  get 'recipes/:id/popup' => 'recipes#popup', as: :recipe_popup
  post 'recipes/:id/reviews' => 'reviews#create', as: :recipe_reviews
  get 'my-recipes', to: "recipes#index_owner", as: :my_recipes
  get 'recipe/new', to: 'recipes#new', as: :new_recipe
  post 'recipes', to: 'recipes#create'
  post 'recipes/:recipe_id/add-to-grocery' => 'grocery_items#add'

  # Steps Routes
  get 'recipes/:recipe_id/steps' => 'steps#index', as: :recipe_steps
  # get 'recipes/:id/steps/:step_number' => 'recipes#steps'

  # Grocery Lists Routes
  get 'grocery-list' => 'grocery_items#index', as: :grocery_items
  post 'grocery-list' => 'grocery_items#create', as: :new_grocery_item
  patch 'grocery-list/:id/check' => 'grocery_items#check', as: :check_grocery_item
  patch 'grocery-list/:id/uncheck' => 'grocery_items#uncheck', as: :uncheck_grocery_item
  patch 'grocery-list/:id/increase' => 'grocery_items#increase', as: :increase_grocery_item
  patch 'grocery-list/:id/decrease' => 'grocery_items#decrease', as: :decrease_grocery_item
  patch 'grocery-list' => 'grocery_items#update'
  delete 'grocery-list/:id' => 'grocery_items#destroy', as: :grocery_item

  # Fridge Routes
  get 'fridge' => 'fridge_items#index', as: :fridge
  post 'fridge' => 'fridge_items#create', as: :add_fridge_item
  delete 'fridge/:id' => 'fridge_items#delete', as: :fridge_item
  patch 'fridge/:id/increase' => 'fridge_items#increase', as: :increase_fridge_item
  patch 'fridge/:id/decrease' => 'fridge_items#decrease', as: :decrease_fridge_item
  patch 'fridge/fill' => 'fridge_items#fill'
  patch 'fridge/empty' => 'fridge_items#empty'

  # Wishist Routes
  get 'wishlist' => 'wishlist_items#index', as: :wishlist_items
  # get 'recipes/:recipe_id/wishlist' => 'wishlist_items#create', as: :new_wishlist_item
  post 'recipes/:recipe_id/wishlist' => 'wishlist_items#create', as: :new_wishlist_item
  # empty fridge when done cooking
  patch 'recipes/:recipe_id/done' => 'fridge_items#empty', as: :empty_fridge


  get '/test' => 'pages#test', as: :test
end
