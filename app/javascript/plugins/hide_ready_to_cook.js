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

  });
}
