$(function(){
  $('#category').on({
    'mouseover': function(){
      $('.category-list').removeClass('hidden');
    },
    'mouseout': function(){
      $('.category-list').addClass('hidden');
    }
  })
  $('.category-list__item').on({
    'mouseover': function(){
      $(this).find('.second-category-list').removeClass('hidden');
    },
    'mouseout': function(){
      $(this).find('.second-category-list').addClass('hidden');
    }
  })
  $('.second-category-list__item').on({
    'mouseover': function(){
      $(this).find('.third-category-list').removeClass('hidden');
    },
    'mouseout': function(){
      $(this).find('.third-category-list').addClass('hidden');
    }
  })
})