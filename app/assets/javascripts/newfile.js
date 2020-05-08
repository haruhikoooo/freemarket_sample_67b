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