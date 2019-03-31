// // DOM読み込みが完了したら実行
// document.addEventListener('DOMContentLoaded', (e) => {
//   // payjp.jsの初期化
//   Payjp.setPublicKey('YOUR_PUBLIC_KEY');
  
//   // ボタンのイベントハンドリング
//   const btn = document.getElementById('token');
//   btn.addEventListener('click', (e) => {
//     e.preventDefault();
    
//     // カード情報生成
//     const card = {
//       number: document.getElementById('card_number').value,
//       cvc: document.getElementById('cvv').value,
//       exp_month: document.getElementById('exp_month').value,
//       exp_year: document.getElementById('exp_year').value
//     };
    
//     // トークン生成
//     Payjp.createToken(card, (status, response) => {
//       if (status === 200) {
//         // 出力（本来はサーバへ送信）
//         document.getElementById('card_token').innerHTML = response.card.id;
//       }
//     });
//   });
// }, false);

/* やること
    ・カードを登録ボタンが押されたら、まずはpay.jsが読み込まれ、トークンが作成
    ・その後にpayコントローラーのcreateアクションでパラメーターでトークンを送信し、トークンを保存する
    
    ・
*/
$(document).on('turbolinks:load', function() {
  var form = $("charge-form");
    number = form.find('input[name="number"]'),
    cvc = form.find('input[name="cvc"]'),
    exp_month = form.find('input[name="exp_month"]'),
    exp_year = form.find('input[name="exp_year"]');
    
  
  $("#charge-form").on("click", "#card-save", function(e) {
    e.preventDefault();
    form.find("input[type=submit]").prop("disabled", true);
    var card = {
        number: $("#payment_card_no").val(),
        cvc: $("#payment_card_security_code").val(),
        exp_month: $("#payment_card_expire_mm").val(),
        exp_year: $("#payment_card_expire_yy").val()
    };
    console.log(card)
    Payjp.createToken(card, function(s, response) {
      console.log(response)
      if (response.error) {
        alert("error")
        form.find('button').prop('disabled', false);
      }
      else {
        $(".number").removeAttr("name");
        $(".cvc").removeAttr("name");
        $(".exp_month").removeAttr("name");
        $(".exp_year").removeAttr("name");
  
        var token = response.id;
        $("#charge-form").append(`<input type="hidden" name="pay_id" class="payjp-token" value=${token} />`)
        
        $("#charge-form").get(0).submit();
      }
    });
  });
  });