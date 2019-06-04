import "bootstrap";
import swal from 'sweetalert';
import 'jquery'
// import 'jquery_ujs'
import slick from 'slick-carousel'
import { loadDynamicBannerText } from '../components/banner';
import { addStep } from '../plugins/add_step'
import { addIngredient } from '../plugins/add_ingredient'
import { wishlistCarousel } from '../plugins/wishlist_carousel'
import { stepsCarousel } from '../plugins/steps_carousel'
import { clickOnRecipeCard } from '../plugins/add_to_wishlist'
import { initSelect2 } from '../plugins/init_select2';
import { clickRightOrLeft } from '../plugins/progress_bar';
import { addEventToHearts } from '../plugins/heart_icon';
import 'select2/dist/css/select2.css';

// import { recipePopup } from '../plugins/recipe_popup'
// import { closeButton } from '../plugins/close_button'

initSelect2();

addIngredient();

addStep();

loadDynamicBannerText();

wishlistCarousel();

stepsCarousel();

clickRightOrLeft();

addEventToHearts();

// clickOnRecipeCard();
