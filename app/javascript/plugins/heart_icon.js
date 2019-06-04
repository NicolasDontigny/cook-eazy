const makeFull = (event) => {
  const icon = event.currentTarget;

  icon.classList.remove('far');
  icon.classList.add('fas');
}

const makeEmpty = (event) => {
  const icon = event.currentTarget;

  icon.classList.remove('fas');
  icon.classList.add('far');
}

const updateLink = (event) => {
  const icon = event.currentTarget;
  const link = event.currentTarget.parentNode;

  icon.classList.toggle('far');
  icon.classList.toggle('fas');

  icon.classList.toggle('add-to-wishlist-empty');
  icon.classList.toggle('add-to-wishlist');

  addEventToHearts();

  setTimeout(() => {
    console.log(link.dataset.method);
    if (link.dataset.method = "post") {
      link.dataset.method = "delete";
    }
    else if (link.dataset.method = "delete") {
      link.dataset.method = "post";
    }

  }, 2000)

}

const addHoverEventToEmpty = (heart) => {
  heart.addEventListener('mouseover', makeFull)
  heart.addEventListener('mouseout', makeEmpty)
}

const addHoverEventToFull = (heart) => {
  heart.addEventListener('mouseout', makeFull)
  heart.addEventListener('mouseover', makeEmpty)
}

const addClickEventToHeart = (heart) => {
  heart.addEventListener('click', updateLink)
}

export const addEventToHearts = () => {
  const emptyHearts = document.querySelectorAll('.add-to-wishlist-empty');

  const fullHearts = document.querySelectorAll('.add-to-wishlist');

  emptyHearts.forEach(addHoverEventToEmpty);
  emptyHearts.forEach(addClickEventToHeart);
  fullHearts.forEach(addHoverEventToFull);
  fullHearts.forEach(addClickEventToHeart);
}
