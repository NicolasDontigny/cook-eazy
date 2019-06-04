import Typed from 'typed.js';
import { end } from 'worker-farm';

const debugTyped = document.getElementById('banner-typed-text');

const loadDynamicBannerText = () => {
    if (debugTyped) {
        new Typed(debugTyped, {
            strings: ["Cook Delicious Meals^1600", "Stop Wasting Food^1600", "Follow Simple Recipes Step-by-Step^1600"],
            typeSpeed: 60,
            smartBackspace: true,
            loop: ["Cook Delicious Meals^1600", "Stop Wasting Food^1600", "Follow Simple Recipes Step-by-Step^1600"],
            loopCount: Infinity,
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
