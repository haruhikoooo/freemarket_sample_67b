$(function(){
  // var opentimer
  // var closetimer
  // var openList
  // var openListThird
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
    const buildFileField = (index)=> {
      const html = `<div data-index="${index}" class="js-file_group">
                      <label>
                        <input class="js-file" type="file"
                        name="good[images_attributes][${index}][src]"
                        id="good_images_attributes_${index}_src"
                        style="display:none">
                        <i class="fas fa-camera fa-2x"></i>
                      </label>
                    </div>`;
      return html;
    }
    // プレビュー用のimgタグを生成する関数
    const buildImg = (index, url)=> {
      const html = `<img data-index="${index}" src="${url}" width="100px" height="100px">`;
      return html;
    }
  
    // file_fieldのnameに動的なindexをつける為の配列
    let fileIndex = [1,2,3,4,5,6,7,8,9,10];
    // 既に使われているindexを除外
    lastIndex = $('.js-file_group:last').data('index');
    fileIndex.splice(0, lastIndex);
  
    $('.hidden-destroy').hide();
  
    $("#image-box").on('change', '.js-file', function(e) {
      const targetIndex = $(this).parents('.js-file_group').data('index');
      // ファイルのブラウザ上でのURLを取得する
      const file = e.target.files[0];
      const blobUrl = window.URL.createObjectURL(file);

      $(this).parents('.js-file_group').addClass("none")
      $('#image-box').append(buildImg(targetIndex, blobUrl));
      // fileIndexの先頭の数字を使ってinputを作る
      $('#image-box').append(buildFileField(fileIndex[0]));
      fileIndex.shift();
      // 末尾の数に1足した数を追加する
      fileIndex.push(fileIndex[fileIndex.length - 1] + 1);
    
    });
  
    $('#image-box').on('click', '.js-remove', function() {
      const targetIndex = $(this).parent().data('index');
      // 該当indexを振られているチェックボックスを取得する
      const hiddenCheck = $(`input[data-index="${targetIndex}"].hidden-destroy`);
      // もしチェックボックスが存在すればチェックを入れる
      if (hiddenCheck) hiddenCheck.prop('checked', true);
  
      $(this).parent().remove();
      $(`img[data-index="${targetIndex}"]`).remove();
  
      // 画像入力欄が0個にならないようにしておく
      if ($('.js-file').length == 0) $('.camera').append(buildFileField(fileIndex[0]));
    });
})