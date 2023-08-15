// ==UserScript==
// @name         AutoClick Disclaimer Button
// @namespace    http://tampermonkey.net/
// @version      1.0
// @description  Auto click a disclaimer button
// @author       lainiwa
// @match        https://www.xvideos.com/*
// @icon         https://www.google.com/s2/favicons?sz=64&domain=xvideos.com
// @grant        none
// ==/UserScript==

(function() {
    'use strict';

    // Function to click the button
    var clickButton = function() {
        var button = document.querySelector('.disclaimer-enter-straightsShortSiteName');
        if(button){
            button.click();
            // Disconnect the observer after clicking the button
            observer.disconnect();
        }
    };

    // Create an observer instance
    var observer = new MutationObserver(clickButton);

    // Configuration of the observer
    var config = { childList: true, subtree: true };

    // Pass in the target node, as well as the observer options
    observer.observe(document.body, config);

})();
