$(function(){
  $('.sub_img').on('mouseover', function(){
    const image = $(this).attr('src')
    $('.goods-content__image--url').attr('src', image)
  })
})