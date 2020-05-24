$(function(){
  function html_after(good){
  let html =
   `<div class="option-area__left--button" data-id="${good.id}" id="option-area__left--button--after">
      <img alt="likes icon" class="option-area__left--button__image" src="/assets/icon/icon_likes-after.png">
      <p>いいね！　${good.likes}</p>
    </div>`
    return html
  };

  function html_before(good){
    let html =
     `<div class="option-area__left--button" data-id="${good.id}" id="option-area__left--button--before">
        <img alt="likes icon" class="option-area__left--button__image" src="/assets/icon/icon_likes-before.png">
        <p>いいね！　${good.likes}</p>
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
    .done(function(good){
      $('#option-area__left--button--before').remove();
      $(".option-area__left").append(html_after(good))
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
    .done(function(good){
      $('#option-area__left--button--after').remove();
      $(".option-area__left").append(html_before(good))
    });
  })
})