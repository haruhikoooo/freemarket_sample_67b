$(function(){
  var form = $("#charge-form");
  Payjp.setPublicKey('pk_test_708c14c6b540c53a94da7107');

  $("#charge-form").on("click", "#token_submit", function(e) {
    

    e.preventDefault();
    form.find("input[type=submit]").prop("disabled", true);

    var card = {
        number: $("#card_number").val(),
        cvc: $("#security_code").val(),
        exp_month: $("#expiration_data_month").val(),
        exp_year: $("#expiration_data_year").val(),
    };
    Payjp.createToken(card, function(s, response) {
      console.log(response)
      if (response.error) {
        alert('トークン作成エラー発生');
      }
      else {
        $(".number").removeAttr("name");
        $(".cvc").removeAttr("name");
        $(".exp_month").removeAttr("name");
        $(".exp_year").removeAttr("name");
        var token = response.id;
        form.append($('<input type="hidden" name="payjpToken" />').val(token));
        form.get(0).submit();
      }
    });
  });
});