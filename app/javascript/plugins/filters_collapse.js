const toggleFilters = (event) => {
  const filtersBar = document.querySelector('#search-filters');

  if (filtersBar.style.visibility == "hidden") {
    // filtersBar.style.width = '100%';
    filtersBar.style.visibility = "visible";
    filtersBar.style.opacity = 1;
  }
  else {
    // filtersBar.style.width = 0;
    filtersBar.style.opacity = 0;

    setTimeout(() => {
      filtersBar.style.visibility = "hidden";
    }, 500)
  }

  filtersBar.classList.toggle('filters-collapsed');

}

export const makeFiltersCollapsable = () => {
  const filterButton = document.querySelector('#toggle-filters');

  if (filterButton) {
    filterButton.addEventListener('click', toggleFilters);
  }
}
