const updateCheckbox = (empty) => {
  console.log(empty)
  const checkboxes = document.querySelectorAll(`a[data='checkbox']`);
  if (checkboxes) {
    if (empty) {
      // checkbox.insertAdjacentHTML("afterend", checkboxHTML);
      checkboxes.forEach(checkbox => {
        checkbox.style.visibility = "hidden";
          }
        );
      // checkbox.style.visibility = "hidden";
    }
    else {

      checkboxes.forEach(checkbox => {
        checkbox.style.visibility = "visible";
        // console.log(checkbox.firstChild);
        checkbox.firstChild.nextElementSibling.classList.remove('fa-check-square');
        checkbox.firstChild.nextElementSibling.classList.add('fa-square')
          }
        );
      // checkbox.style.visibility = "visible";
      // // console.log(checkbox.firstChild);
      // checkbox.firstChild.nextElementSibling.classList.remove('fa-check-square');
      // checkbox.firstChild.nextElementSibling.classList.add('fa-square')
    }
  }
}

window.updateCheckbox = updateCheckbox
