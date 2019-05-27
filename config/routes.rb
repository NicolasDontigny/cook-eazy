Rails.application.routes.draw do
  get 'fridge/show'
  get 'grocery_lists/show'
  get 'recipes/index'
  get 'recipes/steps'
  get 'recipes/show'
  devise_for :users
  root to: 'pages#landing'

  # Recipes Routes
  get 'recipes' => 'recipes#index', as: :recipes

  get 'recipes/:id/steps' => 'recipes#steps', as: :recipe_steps

  get 'recipes/:id' => 'recipes#show', as: :recipe

  # Grocery Lists Routes
  get 'grocery-list' => 'grocery_list_items#index', as: :grocery_list
  post 'grocery-list' => 'grocery_list_items#create', as: :new_grocery_item
  patch 'grocery-list/:id/check' => 'grocery_list_items#check', as: :check_grocery_item
  patch 'grocery-list/:id/uncheck' => 'grocery_list_items#uncheck', as: :uncheck_grocery_item
  patch 'grocery-list/:id/increase' => 'grocery_list_items#increase', as: :increase_grocery_item
  patch 'grocery-list/:id/decrease' => 'grocery_list_items#decrease', as: :decrease_grocery_item
  patch 'grocery-list' => 'grocery_list_items#update'

  # Fridge Routes
  get 'fridge' => 'fridge#show', as: :fridge
  patch 'fridge/add' => 'fridge#add', as: :add_fridge_item
  patch 'fridge/delete' => 'fridge#delete', as: :delete_fridge_item
  patch 'fridge/increase' => 'fridge#increase', as: :increase_fridge_item
  patch 'fridge/decrease' => 'fridge#decrease', as: :decrease_fridge_item
  patch 'fridge/fill' => 'fridge#fill'
  patch 'fridge/empty' => 'fridge#empty'


  # Cooking Lists Routes
  patch 'recipes/:id/add-to-cooking-list' => 'cooking_lists#add', as: :add_recipe_to_cooking_list


end
