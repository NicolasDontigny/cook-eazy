export const toggle = () => {

  const fridgeArrow = document.querySelector('.fridge-arrow');
  const groceryArrow = document.querySelector('.grocery-arrow');

  if (fridgeArrow || groceryArrow) {

    const toggle = (arrow) => {
      const button = arrow.parentNode;
      button.addEventListener('click', () => {
        arrow.classList.toggle('fa-chevron-circle-down');
        arrow.classList.toggle('fa-chevron-circle-up');
        }
      );
    }

    const arrowToggle = (arrow) => {
      toggle(arrow);
    }

    const arrowDropdown = () => {
      if (fridgeArrow) {
        arrowToggle(fridgeArrow);
      } else if (groceryArrow) {
        arrowToggle(groceryArrow);
      }
    }

    arrowDropdown();

  }
}
