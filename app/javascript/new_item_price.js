function price() {

  const priceInput = document.getElementById("item-price");
  priceInput.addEventListener("input", () => {
    const inputValue = priceInput.value;

    const tax = Math.floor(inputValue * 0.1);
    const addTaxDom  = document.getElementById("add-tax-price");
    addTaxDom.innerHTML = tax.toLocaleString();

    const profitDom = document.getElementById("profit");
    const profit = Math.floor(inputValue - tax);
    profitDom.innerHTML = profit.toLocaleString();
  });
};

window.addEventListener("turbo:load", price);
window.addEventListener("turbo:render", price);
