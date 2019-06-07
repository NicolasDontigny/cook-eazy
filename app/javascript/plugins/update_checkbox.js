const updateCheckbox = (empty) => {
  console.log(empty)
  const checkboxes = document.querySelectorAll(`a[data='checkbox']`);
  const button = document.querySelector('.btn-update-groceries');
  console.log(checkboxes)
  if (checkboxes) {
    if (empty) {
      // checkbox.insertAdjacentHTML("afterend", checkboxHTML);
      checkboxes.forEach(checkbox => {
        checkbox.style.visibility = "hidden";
          }
        );
        button.remove();
      // checkbox.style.visibility = "hidden";
    }
    else {

      checkboxes.forEach(checkbox => {
        checkbox.style.visibility = "visible";
        // console.log(checkbox.firstChild);
        checkbox.firstChild.nextElementSibling.classList.remove('fa-check-square');
        checkbox.firstChild.nextElementSibling.classList.add('fa-square');
          }
        );
      const fridgeBody = document.querySelector('.fridge__body');
      if (!button) {
      fridgeBody.insertAdjacentHTML('beforeend', `<a class="button button-main-red
        button-center button-lg btn-update-groceries"
        id="update-grocery" data-remote="true" rel="nofollow"
        data-method="patch" href="/grocery-list">
        Update Grocery List</a>`)
      }
      // checkbox.style.visibility = "visible";
      // // console.log(checkbox.firstChild);
      // checkbox.firstChild.nextElementSibling.classList.remove('fa-check-square');
      // checkbox.firstChild.nextElementSibling.classList.add('fa-square')
    }
  }
}

window.updateCheckbox = updateCheckbox
