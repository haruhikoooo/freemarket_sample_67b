  $(document).on('turbolinks:load', function() {
  // optionの作成
  function appendOption(category){
    var html = `<option value="${category.id}">${category.name}</option>`;
    return html;
  }
   // 子セレクトボックスのhtml作成
  function appendChidrenBox(insertHTML){
    var childSelectHtml = '';
      childSelectHtml = `<div class='product-select-wrapper' id= 'children_wrapper'>
                        <div class='product_category-select'>
                        <select class="category_select-box" id="child_category" name="item[category_id]">
                        <option value="---">---</option>
                        ${insertHTML}
                        </select>
                        <i class='fa fa-chevron-down'></i>
                        </div>
                        <div class= 'product_select-grandchildren'>
                        </div>
                        </div>`;
    $('.product_select-children').append(childSelectHtml);
  }
   // 孫セレクトボックスのhtml作成
  function appendgrandChidrenBox(insertHTML){
    var grandchildrenSelectHtml = '';
    grandchildrenSelectHtml = `<div class='product-select-wrapper' id= 'grandchildren_wrapper'>
                              <div class='product_category-select'>
                              <select class="category_select-box" id="grandchild_category" name="item[category_id]">
                              <option value="---">---</option>
                              ${insertHTML} 
                              </select>
                              <i class='fa fa-chevron-down'></i>
                              </div>
                              <div class= 'product_select-grandchildren'>
                              </div>
                              </div>`;
    $('.product_select-grandchildren').append(grandchildrenSelectHtml);
  }




  // 親セレクトボックスの選択肢を変えたらイベント発火
  $("#item_category_id").on("change", function(){
    console.log(document.getElementById("item_category_id").value);

    // 親ボックスのidを取得してそのidをAjax通信でコントローラーへ送る
    var parentValue = document.getElementById("item_category_id").value;
    // 親ボックスのidが空じゃない時(未選択時のエラー防止)
    if (parentValue != ''){
      $.ajax({
        url: '/items/category_children',
        type: "GET",
        data: {
          parent_id: parentValue // 親ボックスの値をparent_idという変数にする。
        },
        dataType: 'json'
      })
    };