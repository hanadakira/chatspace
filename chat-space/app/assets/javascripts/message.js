
$(document).on('turbolinks:load',function(){
  function buildHTML(message){
    var image_present = message.image? `<img src=${message.image.url}>` : "";
    var html = `<div class='middle-content'>
                  <div class='middle-content__name'>
                    <p>
                      ${ message.user_name }
                    </p>
                  </div>
                  <div class='middle-content__date'>
                    <p>
                      ${ message.date }
                    </p>
                  </div>
                  <div class='middle-content__message'>
                    <p>
                      ${ message.body }
                      ${ image_present }
                    </p>
                  </div>
                </div>`;
                    return html;
                  }
  $('#message_content').on('submit', function(e){
    e.preventDefault();
    var formData = new FormData(this);
    var url = $(this).attr('action');
    $.ajax({
      url: url,
      type: "POST",
      data: formData,
      dataType: 'json',
      processData: false,
      contentType: false
  })
    .done(function(data){
      var html = buildHTML(data);
      $('.middle').append(html);
      $('.footer__content--text').val('')
      $('.hidden').val('')
      $('.middle').animate({scrollTop: $('.middle')[0].scrollHeight}, 'fast');
      $('.footer__content--button').removeAttr("disabled");
    })
    .fail(function(){
      alert('error');
      $('.footer__content--button').removeAttr("disabled");
    })
    return false
  })
setInterval(function() {
  // console.log('${message.id}')
    var id = $('.middle-content').last().data('message-id')
    var url = $(location).attr('pathname')
    $.ajax({
      url:url,
      type: "GET",
      dataType: 'json',
      processData: false,
      data: { id: id},
      contentType: false,
    })
    .done(function(data){
      data.messages.forEach(function(data){
      if(data.id > id){
        var html = buildHTML(data)
        $('.middle').append(html);
      }
    });
    $('.middle').animate({scrollTop: $('.middle')[0].scrollHeight}, 'fast');
    })
    .fail(function(data){
    alert('error');
    });
   } , 5000 );

});
