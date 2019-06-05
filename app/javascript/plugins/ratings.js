const removeSelected = (li) => {
  li.classList.remove('selected');
}

const addSelected = (event) => {
  const star = event.currentTarget;
  const li = star.parentNode.parentNode;

  const siblingLis = li.parentNode.querySelectorAll('li');

  siblingLis.forEach(removeSelected);

  li.classList.add('selected');
}

const mouseoverEvent = (event) => {
  const star = event.currentTarget;
  var li = star.parentNode.parentNode;

  var previousSibling = true
  while (previousSibling) {
    li = li.previousElementSibling;
    if (!li) {
      previousSibling = false;
    }
    else {
      li.classList.add('grayed');
    }
  }
}

const mouseoutEvent = (event) => {
  const star = event.currentTarget;
  var li = star.parentNode.parentNode;

  var previousSibling = true
  while (previousSibling) {
    li = li.previousElementSibling;
    if (!li) {
      previousSibling = false;
    }
    else {
      li.classList.remove('grayed');
    }
  }
}

const addClickEventToStar = (star) => {
  star.addEventListener('click', addSelected);
}

const addHoverEventToStar = (star) => {
  star.addEventListener('mouseover', mouseoverEvent)
  star.addEventListener('mouseout', mouseoutEvent)
}

export const addClickEventToStars = () => {
  const ratingInputs = document.querySelectorAll('.rating-inputs');

  if (ratingInputs.length > 0) {
    ratingInputs.forEach((ratingInput) => {
      const stars = ratingInput.querySelectorAll('i');

      stars.forEach(addClickEventToStar);
      stars.forEach(addHoverEventToStar);
    });
  }
}

window.addClickEventToStars = addClickEventToStars;
