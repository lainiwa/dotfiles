// ==UserScript==
// @name         Atomatic ChatGPT Retry
// @namespace    http://tampermonkey.net/
// @version      1.0
// @description  Automatic retry for ChatGPT
// @author       lainiwa
// @match        https://chat.openai.com/chat
// @icon         https://www.google.com/s2/favicons?sz=64&domain=openai.com
// @grant        none
// ==/UserScript==

var intervalId = window.setInterval(function(){

  let xpath = "//button[text()='Try again']";
  let button = document.evaluate(xpath, document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue;

  if (
    button && (
      document.body.innerText.includes("An error occurred. If this issue persists please contact us through our help center at help.openai.com.") &&
      document.body.innerText.includes("NetworkError when attempting to fetch resource.") &&
    )
  ) {
    button.click();
  }

}, 1000);
