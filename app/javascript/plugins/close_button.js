const closePopup = (event) => {
  console.log(event);
}

const addClickEvent = (button) => {
  console.log("addClickEvent");
  button.addEventListener("click", closePopup);
}

export const closeButton = () => {
  const closeButtons = document.querySelectorAll('.close-popup');
  console.log(closeButtons)
  closeButtons.forEach(addClickEvent);
}
