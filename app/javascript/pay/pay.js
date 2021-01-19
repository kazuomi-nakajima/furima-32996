const pay = () => {
  Payjp.setPublicKey(process.env.PAYJP_PUBLIC_KEY); // PAY.JPテスト公開鍵
  const form = document.getElementById("charge-form");
  form.addEventListener("submit", (e) => {
    e.preventDefault(); //通常のRuby on Railsにおけるフォーム送信処理はキャンセル

    const formResult = document.getElementById("charge-form");
    const formData = new FormData(formResult);

    const card = {  //フォームからカード情報を取得
      number: formData.get("order_processing[number]"),
      cvc: formData.get("order_processing[cvc]"),
      exp_month: formData.get("order_processing[exp_month]"),
      exp_year: `20${formData.get("order_processing[exp_year]")}`,
    };

    Payjp.createToken(card, (status, response) => {
      if (status == 200) { //送信成功時、トークン情報をフォームへ追加
        const token = response.id;
        const renderDom = document.getElementById("charge-form");
        const tokenObj = `<input value=${token} name='token' type="hidden"> `;
        renderDom.insertAdjacentHTML("beforeend", tokenObj);
      }
      //クレカ情報を削除(サーバーサイドには送らないため)
      document.getElementById("card-number").removeAttribute("name");
      document.getElementById("card-cvc").removeAttribute("name");
      document.getElementById("card-exp-month").removeAttribute("name");
      document.getElementById("card-exp-year").removeAttribute("name");
      //送信
      document.getElementById("charge-form").submit();

    });
  });
};

window.addEventListener("load", pay);