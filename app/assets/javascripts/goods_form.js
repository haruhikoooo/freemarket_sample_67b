$(function(){
  // 編集機能実装後コメントアウトを削除する
  const buildFileField = (index)=> {
    const html = `<div class="js-file_group max-width" data-index="${index}">
                    <label class="js-files">
                      <input class="js-file" type="file"
                      name="good[images_attributes][${index}][image]"
                      id="good_images_attributes_${index}_image"
                      style="display:none">
                      <i class="fas fa-camera fa-2x"></i>
                    </label>
                  </div>`;
    return html;
  }
  // プレビュー用のimgタグを生成する関数
  const buildImg = (index, url)=> {
    const html = `<div>
                    <img data-index="${index}" src="${url}" class="js-img">
                    <div class="js-remove">削除</div>
                  </div>`;
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

    // 該当indexを持つimgがあれば取得して変数imgに入れる(画像変更の処理)
    if (img = $(`img[data-index="${targetIndex}"]`)[0]) {
      img.setAttribute('src', blobUrl);
    } else {
      $(this).parents('.js-files').find('.fa-camera').addClass("none");
      $(this).parents('.js-files').find('.camera__comments').addClass("none");
      $(this).parents('.js-files').append(`<div class= "js-update">更新</div>`);
      $(this).parents('.js-file_group').append(buildImg(targetIndex, blobUrl));
      $(this).parents('.js-file_group').removeClass('max-width');
      // fileIndexの先頭の数字を使ってinputを作る
      if ($('.js-files').length < 10){
        $('#image-box').append(buildFileField(fileIndex[0]));
        fileIndex.shift();
        // 末尾の数に1足した数を追加する
        fileIndex.push(fileIndex[fileIndex.length - 1] + 1);
      }
    }
  });

  $('#image-box').on('click', '.js-remove', function() {
    const targetIndex = $(this).parents('.js-file_group').data('index');
    // 該当indexを振られているチェックボックスを取得する
    const hiddenCheck = $(`input[data-index="${targetIndex}"].hidden-destroy`);
    // もしチェックボックスが存在すればチェックを入れる
    if (hiddenCheck) hiddenCheck.prop('checked', true);

    $(`.js-file_group[data-index="${targetIndex}"]`).remove();
    if ($('.js-file').length == 1){
      $('.js-files').append('<p class="camera__comments">クリックしてファイルをアップロード</p>');
    };
    if ($('.js-img').length == 9){
      $('#image-box').append(buildFileField(fileIndex[0]));
      fileIndex.shift();
      // 末尾の数に1足した数を追加する
      fileIndex.push(fileIndex[fileIndex.length - 1] + 1);
    };
  });

  if ($('.hidden-destroy').length){
    $('.js-file_group').each(function(index){
      const targetIndex = $(this).data('index');
      const targetGroup = $(this);
      const img_id = $('#image-box').find(`#good_images_attributes_${index}_id`).prop('value');
      $.ajax({
        url: '/get_image',
        type: 'GET',
        data: { id: img_id },
        dataType: 'json'
      })
      .done(function(image){
        targetGroup.find('.fa-camera').addClass("none");
        targetGroup.find('.camera__comments').addClass("none");
        targetGroup.find('.js-files').append(`<div class= "js-update">更新</div>`);
        targetGroup.removeClass('max-width');
        targetGroup.append(buildImg(targetIndex, image.image.url));
      })
      .fail(function(){
        alert('画像の取得に失敗しました');
      })
    })
    if ($('.js-files').length < 10){
      $('#image-box').append(buildFileField(fileIndex[0]));
      fileIndex.shift();
      // 末尾の数に1足した数を追加する
      fileIndex.push(fileIndex[fileIndex.length - 1] + 1);
    }
  }
});