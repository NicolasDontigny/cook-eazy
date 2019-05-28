import Typed from 'typed.js';

const loadDynamicBannerText = () => {
    new Typed('#banner-typec-text', {
        strings: ["EAT.", "LOVE." , "SAVE"],
        typeSpeed: 50,
        loop: true
    });
}

export { loadDynamicBannerText }