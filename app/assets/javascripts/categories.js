$(function(){
  function appendOption(category){
    var html = `<option value="${category.id}" data-category="${category.id}">${category.name}</option>`;
    return html;
  }

  function appendChidrenBox(insertHTML){
    var childSelectHtml = '';
    childSelectHtml = `<div class='listing-select-wrapper__added' id= 'children_wrapper'>
                        <div class='listing-select-wrapper__box'>
                          <select class="listing-select-wrapper__box--select" id="child_category" name="good[category_id]">
                            <option value="---" data-category="---">---</option>
                            ${insertHTML}
                          <select>
                        </div>
                      </div>`;
    $('#children_box').append(childSelectHtml);
  }

  function appendGrandchidrenBox(insertHTML){
    var grandchildSelectHtml = '';
    grandchildSelectHtml = `<div class='listing-select-wrapper__added' id= 'grandchildren_wrapper'>
                              <div class='listing-select-wrapper__box'>
                                <select class="listing-select-wrapper__box--select" id="grandchild_category" name="good[category_id]">
                                  <option value="---" data-category="---">---</option>
                                  ${insertHTML}
                                </select>
                              </div>
                            </div>`;
    $('#grandchildren_box').append(grandchildSelectHtml);
  }

  $('#parent_category').on('change', function(){
    var parentCategory = document.getElementById('parent_category').value;
    if (parentCategory != "---"){
      $.ajax({
        url: '/get_category_children',
        type: 'GET',
        data: { parent_name: parentCategory },
        dataType: 'json'
      })
      .done(function(children){
        $('#children_wrapper').remove();
        $('#grandchildren_wrapper').remove();
        var insertHTML = '';
        children.forEach(function(child){
          insertHTML += appendOption(child);
        });
        appendChidrenBox(insertHTML);
      })
      .fail(function(){
        alert('カテゴリー取得に失敗しました');
      })
    }else{
      $('#children_wrapper').remove();
      $('#grandchildren_wrapper').remove();
    }
  });
  $('#children_box').on('change', '#child_category', function(){
    var childId = $('#child_category option:selected').data('category');
    if (childId != "---"){
      $.ajax({
        url: '/get_category_grandchildren',
        type: 'GET',
        data: { children_id: childId },
        dataType: 'json'
      })
      .done(function(grandchildren){
        if (grandchildren.length != 0) {
          $('#grandchildren_wrapper').remove();
          var insertHTML = '';
          grandchildren.forEach(function(grandchild){
            insertHTML += appendOption(grandchild);
          });
          appendGrandchidrenBox(insertHTML);
        }
      })
      .fail(function(){
        alert('カテゴリー取得に失敗しました');
      })
    }else{
      $('#grandchildren_wrapper').remove();
    }
  });

  if ($('.listing-select-wrapper').length){
    var firstCategoryData = $('.listing-select-wrapper').data("parent-name")
    var secondCategoryData = $('#children_box').data("child-id")
    var thirdCategoryData = $('#grandchildren_box').data("grandchild-id")
    $('#parent_category').val(firstCategoryData)
    if (firstCategoryData != "---"){
      $.ajax({
        url: '/get_category_children',
        type: 'GET',
        data: { parent_name: firstCategoryData},
        dataType: 'json'
      })
      .done(function(children){
        var insertHTML = '';
        children.forEach(function(child){
          insertHTML += appendOption(child);
        });
        appendChidrenBox(insertHTML);
        $('#child_category').val(secondCategoryData)
        if (thirdCategoryData != "---"){
          $.ajax({
            url: '/get_category_grandchildren',
            type: 'GET',
            data: { children_id: secondCategoryData },
            dataType: 'json'
          })
          .done(function(grandchildren){
            if (grandchildren.length != 0) {
              $('#grandchildren_wrapper').remove();
              var insertHTML = '';
              grandchildren.forEach(function(grandchild){
                insertHTML += appendOption(grandchild);
              });
              appendGrandchidrenBox(insertHTML);
              $('#grandchild_category').val(thirdCategoryData);
              }
          })
          .fail(function(){
            alert('カテゴリー取得に失敗しました');
          })
        }else{
          $('#grandchildren_wrapper').remove();
        }
      })
      .fail(function(){
        alert('カテゴリー取得に失敗しました');
      })
    }else{
      $('#children_wrapper').remove();
      $('#grandchildren_wrapper').remove();
    }
  }
});
