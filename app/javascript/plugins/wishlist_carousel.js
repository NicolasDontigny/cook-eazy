export const wishlistCarousel = () => {
  $(document).ready(function(){
    if (document.getElementById('wishlist-recipes-slider')) {

      $('#wishlist-recipes-slider').slick({
        prevArrow: '<div class="d-flex justify-content-center align-items-center chevron-div"><i class="fas fa-chevron-left"></i></div>',
        nextArrow: '<div class="d-flex justify-content-center align-items-center chevron-div"><i class="fas fa-chevron-right"></i></div>',
        slidesToShow: 3,
        // slidesToScroll: 3,
        // rows: 1,
        // centerMode: true
      });

    }

  });
}
