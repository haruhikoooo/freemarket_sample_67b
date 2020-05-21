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
      }, 100)
      
    },
    'mouseout': function(){
      clearTimeout(opentimer)
      closetimer = setTimeout(function(){
        categoryList.addClass('hidden');
        $('.second-category-list').not('hidden').addClass('hidden');
        $('.third-category-list').not('hidden').addClass('hidden');
      }, 100)
    }
  })
  var opentimerSecond
  var closetimerSecond
  $('.category-list__item--link').on({
    'mouseover': function(){
      var parentCategory = $(this).text();
      $.ajax({
        url: '/get_category_children',
        type: 'get',
        data: { parent_name: parentCategory },
        dataType: 'json'
      })
      .done(function(children){
        $('.second-category-list__item--link').remove();
        children.forEach(function(child){
          var html_child = `<a class="second-category-list__item--link" id="${child.id}" href="/goods/category/${child.id}">${child.name}</a>`
          $('.second-category-list__item').append(html_child)
        });
        clearTimeout(closetimerSecond)
        openList = $(document).find('.second-category-list')
        opentimerSecond = setTimeout(function(){
          $('.second-category-list').not('hidden').addClass('hidden');
          $(openList).removeClass('hidden');
      }, 100)
      });
    },
    // 以下、最終調整のため残しておきます。 
    // 'mouseout': function(){
    //   clearTimeout(opentimerSecond);
    //   var closeList = $(document).find('.second-category-list')
    //   closetimerSecond = setTimeout(function(){
    //     $(closeList).addClass('hidden');
    //     if(openListThird) $(openListThird).addClass('hidden');
    //   }, 100)
    // }
  })
  var opentimerThird
  var closetimerThird
  $(document).on("mouseover",".second-category-list__item--link", function(){
      var childrenCategory = $(this).attr("id");
      $.ajax({
        url: '/get_category_grandchildren',
        type: 'get',
        data: { children_id: childrenCategory },
        dataType: 'json'
      })
      .done(function(grandchildren){
        $('.third-category-list__item--link').remove();
        grandchildren.forEach(function(grandchild){
          var html_grandchild = `<a class="third-category-list__item--link" id="grandchild_${grandchild.id}" href="/goods/category/${grandchild.id}">${grandchild.name}</a>`
          $('.third-category-list__item').append(html_grandchild)
        });
      clearTimeout(closetimerThird)
      openListThird = $(document).find('.third-category-list')
      opentimerThird = setTimeout(function(){
        $('.third-category-list').not('hidden').addClass('hidden');
        $(openListThird).removeClass('hidden');
      }, 100)
      });
    })
  // 以下、最終調整のため残しておきます。
  // $(document).on('mouseout','.second-category-list__item--link', function(){
  //   clearTimeout(opentimerThird);
  //   var closeListThird = $(document).find('.third-category-list')
  //   closetimerThird = setTimeout(function(){
  //     $(closeListThird).addClass('hidden');
  //   }, 100)
  // })
})

