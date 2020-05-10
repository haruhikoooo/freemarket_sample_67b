$(function(){
  //入力時のイベント    
  $('.sample').on('input', function(){
      //文字数を取得
      var cnt = $(this).val().length;
      //現在の文字数を表示
      $('.now_cnt').text(cnt);
  }); 
  //リロード時に初期文字列が入っていた時の対策
  $('.sample').trigger('input');
});


$(function(){
  $('.money').on('input',function() {
    // 販売金額を定義
    var data = $('.money').val();
    // 販売利益を定義(販売金額の１割引)
    var profit = Math.round(data * 0.9)
    // 手数料の定義
    var fee = (data - profit)
    $('.five-line').html(fee)
    $('.five-line').prepend('¥')
    $('.sales-profit__2line').html(profit)
    // 販売利益に￥をつける
    $('.sales-profit__2line').prepend('¥')
  });
})

function formCheck(){
  var flag = 0;

  // 入力必須項目が入力されているかチェック
  if( document . Form1 . InputText1 . value == "" ){ // 名前が未入力の場合
      flag = 1;
      document . getElementById( 'notice-input-text-1' ) . style . display = "block"; // 【名前を入力して下さい】を表示
  }else{ // 名前が入力済みの場合
      document . getElementById( 'notice-input-text-1' ) . style . display = "none"; // 【名前を入力して下さい】を非表示
  }
  if( document . Form1 . Textarea1 . value == "" ){ // コメントが未入力の場合
      flag = 1;
      document . getElementById( 'notice-textarea-1' ) . style . display = "block"; // 【コメントを入力して下さい】を表示
  }else{ // コメントが入力済みの場合
      document . getElementById( 'notice-textarea-1' ) . style . display = "none"; // 【コメントを入力して下さい】を非表示
  }

  if( flag ){ // 入力必須項目に未入力があった場合
      window . alert( '必須項目は全て入力して下さい。' ); // アラートを表示
      return false; // 送信中止
  }else{ // 入力必須項目が全て入力済みだった場合
      return true; // 送信実行
  }

}