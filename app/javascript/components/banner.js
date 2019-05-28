import Typed from 'typed.js';

const loadDynamicBannerText = () => {
    new Typed('#banner-typed-text', {
        strings: ["EAT.^1600 LOVE.^1600 SAVE.^1600"],
        typeSpeed: 30,
        fadeOut: true,
        backSpeed: 0,
        backDelay: 0,
        startDelay: 1600,
        cursorChar: "",
        loop: true
    });
}

export { loadDynamicBannerText }