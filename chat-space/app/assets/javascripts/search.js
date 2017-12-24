$(document).on('turbolinks:load', function(){
  var search_list = $("#user-search-result");

  function appendUser(user) {
    var html = `<div class="chat-group-user clearfix">
                <p class="chat-group-user__name">${ user.name }</p>
                <a class="user-search-add chat-group-user__btn
                chat-group-user__btn--add" data-user-id="${ user.id }" data-user-name="${ user.name }">追加</a>
                </div>`
    search_list.append(html);
  }
  function appendNoUser(user) {
    var html = `<div class="chat-group-user clearfix">
                  <p class="chat-group-user_name">${user}</p>
                </div>`
    search_list.append(html);
  }

  $("#user-search-field").on("keyup", function(e) {
    e.preventDefault();
    var input = $("#user-search-field").val();
    $.ajax({
      type: 'GET',
      url: '/users',
      data: {keyword: input},
      dataType: 'json'
    })
    .done(function(users) {
      $("#user-search-result").empty();
        if (users.length !== 0) {
          users.forEach( function(user){
             appendUser(user);
          });
        }
        else {
          appendNoUser("該当するユーザーは存在しません");
        }
    })
    .fail(function(data) {
      alert('検索に失敗しました');
    });
  });
    function addUser(user_id, user_name) {
        var html = `<div class='chat-group-user clearfix js-chat-member' id='chat-group-user-8'>
                      <input name='group[user_ids][]' type='hidden' value='${ user_id }'>
                      <p class='chat-group-user__name'> ${user_name} </p>
                      <a class='user-search-remove chat-group-user__btn chat-group-user__btn--remove js-remove-btn'>削除</a>
                    </div>`
        $("#chat-group-users").append(html);
    }

    $(".chat-group-form__field--right").on("click", ".user-search-add", function() {
       var user = $(this)
       user_id = user.data('user-id')
       user_name = user.data('user-name')

         addUser(user_id, user_name)
         $(this).parent().remove();
    })
    $(function() {
      $(".chat-group-form__field--right").on("click",".user-search-remove", function() {
        var user = $(this).parent();
        user.remove();
      })
    })
});
