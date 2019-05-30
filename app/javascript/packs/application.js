import "bootstrap";
import swal from 'sweetalert';
import 'jquery'
import slick from 'slick-carousel'

// import { recipePopup } from '../plugins/recipe_popup'
// import { closeButton } from '../plugins/close_button'

import 'select2/dist/css/select2.css';
import { initSelect2 } from '../plugins/init_select2';
initSelect2();

import { addStep } from '../plugins/add_step'
addStep();
import { addIngredient } from '../plugins/add_ingredient'
addIngredient();

import { loadDynamicBannerText } from '../components/banner';
loadDynamicBannerText();

import { wishlistCarousel } from '../plugins/wishlist_carousel'

wishlistCarousel();
