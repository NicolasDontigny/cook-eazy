import Typed from 'typed.js';
import { end } from 'worker-farm';

const debugTyped = document.getElementById('banner-typed-text');

const loadDynamicBannerText = () => {
    if (debugTyped) {
        new Typed(debugTyped, {
            strings: ["EAT.^1600 LOVE.^1600 SAVE.^1600"],
            typeSpeed: 30,
            fadeOut: true,
            backSpeed: 0,
            backDelay: 0,
            // startDelay: 1600,
            cursorChar: "",
            loop: true
        });
    };
};

export { loadDynamicBannerText };
