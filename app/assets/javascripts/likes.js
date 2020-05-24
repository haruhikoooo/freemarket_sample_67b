$(function(){
  function html_after(likes){
  let html =
   `<div class="option-area__left--button" data-id="1" id="option-area__left--button--after">
      <img alt="likes icon" class="option-area__left--button__image" src="/assets/icon/icon_likes-after.png">
      <p>いいね！　${likes}</p>
    </div>`
    return html
  };

  function html_before(likes){
    let html =
     `<div class="option-area__left--button" data-id="1" id="option-area__left--button--before">
        <img alt="likes icon" class="option-area__left--button__image" src="/assets/icon/icon_likes-before.png">
        <p>いいね！　${likes}</p>
      </div>`
      return html
    };

  $(document).on("click","#option-area__left--button--before", function(){
    let good_id = $(this).data('id');
    $.ajax({
      url: '/likes/create',
      type: 'get',
      data: { good_id: good_id },
      dataType: 'json'
    })
    .done(function(likes){
      $('#option-area__left--button--before').remove();
      $(".option-area__left").append(html_after(likes))
    });
  });
  
  $(document).on("click","#option-area__left--button--after", function(){
    let good_id = $(this).data('id');
    $.ajax({
      url: '/likes/destroy',
      type: 'get',
      data: { good_id: good_id },
      dataType: 'json'
    })
    .done(function(likes){
      $('#option-area__left--button--after').remove();
      $(".option-area__left").append(html_before(likes))
    });
  })
})