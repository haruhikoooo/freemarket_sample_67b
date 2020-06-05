$(document).on('turbolinks:load', function() {
  var form = $("#token_submit");
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
        console.log(token)
        form.append($('<input type="hidden" name="payjpToken" />').val(token));
        form.get(0).submit();
      }
    });
  });
});