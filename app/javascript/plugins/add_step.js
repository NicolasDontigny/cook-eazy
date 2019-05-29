const createStepInput = (orderNumber) => {
  return(`
    <div class="form-group text required recipe_steps_content">
      <label class="form-control-label text required" for="recipe_steps_attributes_${orderNumber}_content">
        Step ${orderNumber + 1} <abbr title="required">*</abbr>
      </label>
      <textarea class="form-control text required" name="recipe[steps_attributes][${orderNumber}][content]" id="recipe_steps_attributes_${orderNumber}_content"></textarea>
    </div>
    <input type="hidden" name="recipe[steps_attributes][${orderNumber}][order]" id="recipe_steps_attributes_${orderNumber}_order" value="${orderNumber + 1}" />
  `)
}

const addField = () => {
  const stepsContainer = document.getElementById('steps_container');
  const lastChild = document.querySelector('#steps_container input:last-child');
  const value = parseInt(lastChild.value, 10);
  const field = createStepInput(value);
  stepsContainer.insertAdjacentHTML("beforeend", field);
}

const addClickEvent = (addStepButton) => {
  addStepButton.addEventListener("click", addField)
}

export const addStep = () => {
  const addStepButton = document.getElementById('add_step');
  if (addStepButton) {
   addClickEvent(addStepButton);
  }
}
