const initUpdateNavbarOnScroll = () => {
  const navbar = document.querySelector('.navbar-lewagon-white');
  if (navbar) {
    window.addEventListener('scroll', () => {
      if (window.scrollY >= window.innerHeight) {
        navbar.classList.add('navbar-lewagon');
        navbar.classList.remove('navbar-lewagon-white');
      } else {
        navbar.classList.remove('navbar-lewagon');
      }
    });
  }
}

export { initUpdateNavbarOnScroll };
