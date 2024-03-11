const pay = () => {
  const payjp = Payjp('******************************')
  const elements = payjp.elements();
  const numberElements = elements.create("cardNumber");
  const expiryElements = elements.create("cardExpiry");
  const cvcElements = elements.create("cardCvc");

  numberElements.mount("#number-form");
  expiryElements.mount("#expiry-form");
  cvcElements.mount("#cvc-form");

  const form = document.getElementById("charge-form")
  form.addEventListener("submit", (e) => {
    payjp.createToken(numberElements).then(function (response) {
      if (response.error) {
      } else {
        const token = response.id;
        const renderDom = document.getElementById("charge-form");
        const tokenObj = `<input value=${token} name='token' type="hidden">`;
        renderDom.insertAdjacentHTML("beforeend", tokenObj);
        console.log(token)
      }
    });
    e.preventDefault();
  });
};

window.addEventListener("turbo:load", pay);