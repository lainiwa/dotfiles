// ==UserScript==
// @name         alison.com auto starter
// @namespace    http://tampermonkey.net/
// @version      1.0
// @description  Auto click "Start topic" on alison.com
// @match        https://alison.com/topic/learn/*
// @author       lainiwa
// @grant        none
// ==/UserScript==

window.addEventListener('load', function() {
    let elem = document.getElementById("player_button_right");
    elem.classList.add('ready');
    elem.click()
}, false);
