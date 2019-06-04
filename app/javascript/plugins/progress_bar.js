var refreshBar = (event) => {
  setTimeout(() => {
    var order = parseInt(document.querySelector('.slick-slide.slick-active').querySelector('.recipe-order').innerText)

    var progressFraction = document.querySelector('.progress-fraction');

    var recipeStepsContainer = document.getElementById('recipe-steps');

    var numberOfSteps = recipeStepsContainer.dataset.steps;

    var width = 100 / numberOfSteps * order

    progressFraction.style.width = `${width}%`


    var leftChevronDiv = document.querySelector('.fa-chevron-left').parentNode;
    var rightChevronDiv = document.querySelector('.fa-chevron-right').parentNode;
    var doneCookingButton = document.getElementById('done-cooking')

    if (numberOfSteps == 1) {
      doneCookingButton.style.visibility = "visible";
    }
    else if (order == numberOfSteps) {
      rightChevronDiv.style.visibility = "hidden";
      leftChevronDiv.style.visibility = "visible";

      doneCookingButton.style.visibility = "visible";
    }
    else if (order == 1) {
      leftChevronDiv.style.visibility = "hidden";
      rightChevronDiv.style.visibility = "visible";

      doneCookingButton.style.visibility = "hidden";
    }
    else {
      leftChevronDiv.style.visibility = "visible";
      rightChevronDiv.style.visibility = "visible";

      doneCookingButton.style.visibility = "hidden";
    }
  }, 200)
}

export var clickRightOrLeft = () => {
  if (document.querySelector('#progress-bar')) {
    setTimeout(() => {
      var chevronDivs = document.querySelectorAll('.chevron-div');
      if (chevronDivs.length > 0) {
        chevronDivs.forEach((chevronDiv) => {
          chevronDiv.addEventListener('click', refreshBar);
        });

      }


    }, 1000)

    var recipeStepsContainer = document.getElementById('recipe-steps');

    var numberOfSteps = recipeStepsContainer.dataset.steps;
    var doneCookingButton = document.getElementById('done-cooking')

    if (numberOfSteps == 1) {
      doneCookingButton.style.visibility = "visible";
    }
  }

}
