document.addEventListener("turbolinks:load", function() {
  $('[data-toggle="tooltip"]').tooltip()
  $('.rate-course').hide();


  // Comments graduate rating
  $('#comment_graduate').change(function(){
    if(this.checked)
      $('.rate-course').fadeIn('fast');
    else
      $('.rate-course').fadeOut('fast');
  });


  // Validating comment length
  $('#comment_content').keyup(function() {
    var empty = false;
    $('#comment_content').each(function() {
      if ($(this).val().length == 0) {
        empty = true;
      }
    });

    if (empty) {
      $('#submit_comment').attr('disabled', 'disabled');
    } else {
      $('#submit_comment').removeAttr('disabled');
    }
  });
});
