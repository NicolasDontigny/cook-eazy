const updateCheckbox = (empty) => {
  console.log(empty)
  const checkbox = document.querySelector(`a[data='checkbox']`);
  if (checkbox) {
    if (empty) {
      // checkbox.insertAdjacentHTML("afterend", checkboxHTML);
      checkbox.style.visibility = "hidden";
    }
    else {
      checkbox.style.visibility = "visible";
      // console.log(checkbox.firstChild);
      checkbox.firstChild.nextElementSibling.classList.remove('fa-check-square');
      checkbox.firstChild.nextElementSibling.classList.add('fa-square')
    }
  }
}

window.updateCheckbox = updateCheckbox
