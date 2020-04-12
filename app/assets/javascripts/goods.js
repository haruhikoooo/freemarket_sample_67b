$(function(){
  var opentimer
  var closetimer
  var openList
  var openListThird
  var categoryList = $('.category-list')
  $('#category').on({
    'mouseover': function(){
      clearTimeout(closetimer)
      opentimer = setTimeout(function(){
        categoryList.removeClass('hidden');
      }, 500)
    },
    'mouseout': function(){
      clearTimeout(opentimer)
      closetimer = setTimeout(function(){
        categoryList.addClass('hidden');
        $('.second-category-list').not('hidden').addClass('hidden');
        $('.third-category-list').not('hidden').addClass('hidden');
      }, 400)
    }
  })
  var opentimerSecond
  var closetimerSecond
  $('.category-list__item').on({
    'mouseover': function(){
      clearTimeout(closetimerSecond)
      openList = $(this).find('.second-category-list')
      opentimerSecond = setTimeout(function(){
        $('.second-category-list').not('hidden').addClass('hidden');
        $(openList).removeClass('hidden');
      }, 500)
    },
    'mouseout': function(){
      clearTimeout(opentimerSecond);
      var closeList = $(this).find('.second-category-list')
      closetimerSecond = setTimeout(function(){
        $(closeList).addClass('hidden');
        if(openListThird) $(openListThird).addClass('hidden');
      }, 400)
    }
  })
  var opentimerThird
  var closetimerThird
  $('.second-category-list__item').on({
    'mouseover': function(){
      clearTimeout(closetimerThird)
      openListThird = $(this).find('.third-category-list')
      opentimerThird = setTimeout(function(){
        $('.third-category-list').not('hidden').addClass('hidden');
        $(openListThird).removeClass('hidden');
      }, 500)
    },
    'mouseout': function(){
      clearTimeout(opentimerThird);
      var closeListThird = $(this).find('.third-category-list')
      closetimerThird = setTimeout(function(){
        $(closeListThird).addClass('hidden');
      }, 400)
    }
  })
})