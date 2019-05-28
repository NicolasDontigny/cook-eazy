import Typed from 'typed.js';

const xxx = document.getElementById('banner-typed-text');

const loadDynamicBannerText = () => {
    if(xxx) {
        new Typed(xxx, {
            strings: ["EAT.", "LOVE." , "SAVE"],
            typeSpeed: 50,
            loop: true
        });
    }
}

export { loadDynamicBannerText }