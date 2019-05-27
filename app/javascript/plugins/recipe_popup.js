const popup = (event) => {
  const recipe_id = event.currentTarget.dataset["recipeId"];
  const container = document.querySelector('.container');
  const div =
  "<div class='opacity-background'> \
    <div class='recipe-card-popup'> \
      <h4>Recipe Name</h4>\
    </div>\
  </div>";
  container.insertAdjacentHTML("afterend", div);
}

const addClickEvent = (recipeCard) => {
  recipeCard.addEventListener("click", popup)
}

export const recipePopup = () => {
  const recipeCards = document.querySelectorAll('.recipe-card');
  recipeCards.forEach(addClickEvent);
}
