import "bootstrap";
import swal from 'sweetalert';
import 'jquery'
import slick from 'slick-carousel'
import { loadDynamicBannerText } from '../components/banner';
import { addStep } from '../plugins/add_step'
import { wishlistCarousel } from '../plugins/wishlist_carousel'
import { stepsCarousel } from '../plugins/steps_carousel'


// import { recipePopup } from '../plugins/recipe_popup'
// import { closeButton } from '../plugins/close_button'


addStep();

loadDynamicBannerText();

wishlistCarousel();

stepsCarousel();
