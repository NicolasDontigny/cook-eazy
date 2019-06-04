export var wishlistCarousel = () => {
  $(document).ready(function(){
    var wishlistContainer = document.getElementById('wishlist-recipes-slider');

    if (wishlistContainer) {
      var wishlistItems = wishlistContainer.querySelectorAll('.wishlist-link');

      if (wishlistItems.length > 3) {
        var slidesToShow = 3;
      }
      else if (wishlistItems.length == 3) {
        var slidesToShow = 2;
      }
      else {
        var slidesToShow = 1;
      }

      if (wishlistItems.length > 1) {
        $('#wishlist-recipes-slider').not('.slick-initialized').slick({
          prevArrow: '<div class="d-flex justify-content-center align-items-center chevron-div pr-3"><i class="fas fa-chevron-left"></i></div>',
          nextArrow: '<div class="d-flex justify-content-center align-items-center chevron-div pl-3"><i class="fas fa-chevron-right"></i></div>',
          slidesToShow: slidesToShow,
          slidesToScroll: slidesToShow,
          infinite: true,
          // centerMode: true,
          // centerPadding: '20px',

          responsive: [
              {
                breakpoint: 994,
                settings: {
                  slidesToShow: 2,
                  slidesToScroll: 2
                }
              },
              {
                breakpoint: 768,
                settings: {
                  slidesToShow: 1,
                  slidesToScroll: 1
                }
              }
          ]
        });

      }

    }

  });
}

const unslick = () => {
  console.log("unslick");

  $('#wishlist-recipes-slider').slick('unslick');
}

const slick = () => {
  console.log("slick");

  wishlistCarousel();
}

window.unslick = unslick;
window.slick = slick;

