// const makeFull = (event) => {
//   const icon = event.currentTarget;

//   icon.classList.remove('far');
//   icon.classList.add('fas');
// }

const changeIcon = (event) => {
  const icon = event.currentTarget;

  icon.classList.toggle('far');
  icon.classList.toggle('fas');
}

// const makeEmpty = (event) => {
//   const icon = event.currentTarget;

//   icon.classList.remove('fas');
//   icon.classList.add('far');
// }

const updateLink = (event) => {
  const icon = event.currentTarget;
  const link = event.currentTarget.parentNode;

  changeIcon(event);

  icon.classList.toggle('add-to-wishlist-empty');
  icon.classList.toggle('add-to-wishlist');

  setTimeout(() => {
    console.log(link.dataset.method);
    if (link.dataset.method == "post") {
      link.dataset.method = "delete";
    }
    else if (link.dataset.method == "delete") {
      link.dataset.method = "post";
    }

    console.log(link.dataset.method);

  }, 2000)

}

const addHoverEventToHeart = (heart) => {
  heart.addEventListener('mouseover', changeIcon)
  heart.addEventListener('mouseout', changeIcon)
}

// const addHoverEventToFull = (heart) => {
//   heart.addEventListener('mouseout', makeFull)
//   heart.addEventListener('mouseover', makeEmpty)
// }

const addClickEventToHeart = (heart) => {
  heart.addEventListener('click', updateLink)
}

export const addEventToHearts = () => {
  const hearts = document.querySelectorAll('.fa-heart');

  hearts.forEach(addHoverEventToHeart);

  hearts.forEach(addClickEventToHeart);

  // const fullHearts = document.querySelectorAll('.add-to-wishlist');

  // emptyHearts.forEach(addHoverEventToEmpty);
  // emptyHearts.forEach(addClickEventToHeart);
  // fullHearts.forEach(addHoverEventToFull);
  // fullHearts.forEach(addClickEventToHeart);
}
