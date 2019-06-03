export const stepsCarousel = () => {
  $(document).ready(function(){
    if (document.getElementById('recipe-steps')) {

      $('#recipe-steps').slick({
        prevArrow: '<div class="d-flex justify-content-center align-items-center chevron-div" style="visibility: hidden;"><i class="fas fa-chevron-left"></i></div>',
        nextArrow: '<div class="d-flex justify-content-center align-items-center chevron-div"><i class="fas fa-chevron-right"></i></div>',
        slidesToShow: 1,
        // dots: true,
        appendDots: $('#steps-dots')
        // slidesToScroll: 3,
        // rows: 1,
        // centerMode: true
      });

    }

  });
}
