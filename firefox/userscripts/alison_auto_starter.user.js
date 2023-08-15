// ==UserScript==
// @name         The alison.com auto starter
// @namespace    http://tampermonkey.net/
// @version      1.0
// @description  Auto click "Start topic" on alison.com
// @author       lainiwa
// @match        https://alison.com/topic/learn/*
// @icon         https://www.google.com/s2/favicons?sz=64&domain=alison.com
// @grant        none
// ==/UserScript==

window.addEventListener('load', function() {
    let elem = document.getElementById("player_button_right");
    elem.classList.add('ready');
    elem.click()
}, false);
