document.addEventListener(
  "DOMContentLoaded", e => {//DOM読み込みが完了したら実行
    if (document.getElementById("token_submit") != null) { //token_submitというidがnullの場合、下記コードを実行しない
      Payjp.setPublicKey("pk_test_708c14c6b540c53a94da7107"); //ここに公開鍵を直書き
      let btn = document.getElementById("token_submit"); //IDがtoken_submitの場合に取得
      btn.addEventListener("click", e => { //ボタンが押されたときに作動
        e.preventDefault(); //ボタンを一旦無効
        let card = {//カード情報生成
          number: document.getElementById("card_number").value,
          security_code: document.getElementById("security_code").value,
          expiration_data_month: document.getElementById("expiration_data_month").value,
          expiration_data_year: document.getElementById("expiration_data_year").value
        }; //入力されたデータを取得
        Payjp.createToken(card, (status, response) => {//トークン生成
          if (status === 200) { //成功した場合
            $("#card_number").removeAttr("name");
            $("#security_code").removeAttr("name");
            $("#expiration_data_month").removeAttr("name");
            $("#expiration_data_year").removeAttr("name"); //データを自サーバにpostしないように削除
            $("#card_token").append(
              $('<input type="hidden" name="payjp-token">').val(response.id)
            ); //取得したトークンを送信できる状態
            document.inputForm.submit();
            alert("登録が完了しました"); 
          } else {
            alert("カード情報が正しくありません。"); 
          }
        });
      });
    }
  },
  false
);


$(document).on('turbolinks:load', function() {
  var form = $("#charge-form");
  Payjp.setPublicKey('pk_test_708c14c6b540c53a94da7107');
  $(document).on("click", "#token_submit", function(e) {

    e.preventDefault();
    form.find("input[type=submit]").prop("disabled", true);

    var card = {
      card_number: $("#card_number").val(),
        security_code: $("#security_code").val(),
        expiration_data_month: $("#expiration_data_month").val(),
        expiration_data_year: $("#expiration_data_year").val(),
    };
    Payjp.createToken(card, function(s, response) {
      if (response.error) {
        alert('トークン作成エラー発生');
      }
      else {
        $(".card_number").removeAttr("name");
        $(".security_code").removeAttr("name");
        $(".expiration_data_month").removeAttr("name");
        $(".expiration_data_year").removeAttr("name");
        var token = response.id;

        form.append($('<input type="hidden" name="payjpToken" />').val(token));
        form.get(0).submit();
      }
    });
  });
});