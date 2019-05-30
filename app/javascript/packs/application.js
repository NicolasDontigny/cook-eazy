import "bootstrap";
import swal from 'sweetalert';
import 'jquery'
import slick from 'slick-carousel'

// import { recipePopup } from '../plugins/recipe_popup'
// import { closeButton } from '../plugins/close_button'

import { addStep } from '../plugins/add_step'

addStep();



import { loadDynamicBannerText } from '../components/banner';
loadDynamicBannerText();

import { wishlistCarousel } from '../plugins/wishlist_carousel'

wishlistCarousel();
