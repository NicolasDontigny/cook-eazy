export const hideReadyToCookIfEmpty = () => {
  $(document).ready(function(){
    const h2 = document.getElementById('ready-to-cook');

    if (h2) {
      const readyToCookContainer = document.getElementById('ready-to-cook-container');

// <<<<<<< HEAD
//     if (readyToCookContainer) {
// =======
// >>>>>>> master
      const numberOfRecipeCards = readyToCookContainer.querySelectorAll('.recipe-card').length;

      if (numberOfRecipeCards == 0) {
        h2.style.display = 'none';
      }
    }

    const h2RecipesForYou = document.getElementById('recipes-for-you');

    if (h2RecipesForYou) {
      const recipesForYouContainer = document.getElementById('recipes-for-you-container');

      const numberOfRecipeCardsRecipes = recipesForYouContainer.querySelectorAll('.recipe-card').length;

      if (numberOfRecipeCardsRecipes == 0) {
        h2RecipesForYou.style.display = 'none';
      }
    }


  });
}
