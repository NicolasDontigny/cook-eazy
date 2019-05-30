const createIngredientInput = (ingredientNumber) => {
  const ingredientsJson = document.getElementById('ingredients').dataset.ingredients;
  const ingredients = JSON.parse(ingredientsJson);
  const ingredientsOptionTags = ingredients.map( (ingredient) => {
      return `<option value="${ingredient.id}">${ingredient.name}</option>`;
    }
  )
  const ingredientsString = ingredientsOptionTags.join('');
  return(`
    <div class="form-group select required recipe_recipe_items_ingredient"><label class="form-control-label select required" for="recipe_recipe_items_attributes_${ingredientNumber}_ingredient_id">Ingredient ${ingredientNumber + 1} <abbr title="required">*</abbr></label>
        <select class="form-control select required select2" name="recipe[recipe_items_attributes][${ingredientNumber}][ingredient_id]" id="recipe_recipe_items_attributes_${ingredientNumber}_ingredient_id">
          ${ingredientsString}
        </select>
    </div>
    <div class="form-group integer optional recipe_recipe_items_quantity">
    <label class="form-control-label integer optional" for="recipe_recipe_items_attributes_${ingredientNumber}_quantity">Quantity
    </label>
    <input class="form-control numeric integer optional" type="number" step="${ingredientNumber + 1}" name="recipe[recipe_items_attributes][${ingredientNumber}][quantity]" id="recipe_recipe_items_attributes_${ingredientNumber}_quantity" />
    </div>
  `);
}

const addField = () => {
  const ingredientContainer = document.getElementById('ingredients_container');
  const allIngredientInputs = document.querySelectorAll('.recipe_recipe_items_quantity input');
  const lastChild = allIngredientInputs[allIngredientInputs.length - 1]
  const ingredientNumber = parseInt(lastChild.getAttribute('step'), 10);
  const field = createIngredientInput(ingredientNumber);
  ingredientContainer.insertAdjacentHTML("beforeend", field);
}

const addClickEvent = (addIngredientButton) => {
  addIngredientButton.addEventListener("click", addField)
}

export const addIngredient = () => {
  const addIngredientButton = document.getElementById('add_ingredient');
  if (addIngredientButton) {
   addClickEvent(addIngredientButton);
  }
}
