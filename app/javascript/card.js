const pay = () => {

  const payjp = Payjp('******************************')
  const elements = payjp.elements();
  const numberElements = elements.create("cardNumber");
  const expiryElements = elements.create("cardExpiry");
  const cvcElemnts = elements.create("cardCvc");

  numberElements.mount("#number-form");
  expiryElements.mount("#expiry-form");
  cvcElemnts.mount("#cvc-form");

  const form = document.getElementById("charge-form")
  form.addEventListener("submit", (e) => {
    console.log("フォーム送信時にイベント発火")
    e.preventDefault();
  });
};

window.addEventListener("turbo:load", pay);