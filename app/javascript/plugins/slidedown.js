// console.log($('body'));

const stepWrapper = $('.step_wrapper');

if (stepWrapper.length === 1) {

  $(document).ready(function(){
    // setTimeout(() => {
    //   setTimeout(() => {
    //     stepWrapper[0].style.position = 'static';
    //   }, 200)
    // }, 200)

    $(".start-cooking").click(function(){
      if ($(".step_wrapper")[0].style.maxHeight === '100px') {
        $(".step_wrapper")[0].style.maxHeight = '0px';
      } else {
        $(".step_wrapper")[0].style.maxHeight = '300px';

      }
      // $(".step_wrapper")[0].style.opacity = 1;
    });

  });

}
