$(function(){
  $(document).on('turbolinks:load',function(){
  function buildHTML(message){
    console.log(message.image);
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
${ message.body}
<img src="${ message.image.url }">
</p>
</div>
</div>`
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
      $('.footer__content--button').removeAttr("disabled");
    })
    .fail(function(){
      alert('error');
    })
  })
});
});
