function price_calculation() {   // 料金計算関数

  const price = document.getElementById("item-price");

  price.addEventListener("keyup", () =>{
    const money = parseInt(price.value, 10);
    
    //手数料・利益フォーム参照
    const tax = document.getElementById("add-tax-price");
    const profit = document.getElementById("profit");

    //手数料・利益計算
    let taxPrice =  Math.floor(money * 0.1);
    let profitPrice = Math.floor(money - taxPrice);

    //HTMLに表示
    if(!isNaN(taxPrice)){
      tax.innerHTML = `${taxPrice}`;
      profit.innerHTML = `${profitPrice}`;
    }else {       //入力が数値以外が入力されたら計算しない
      tax.innerHTML = ``;
      profit.innerHTML = ``;
    }
  })
}

//ページが読み込まれた時price_calculationの処理を実行
window.addEventListener('load', price_calculation);