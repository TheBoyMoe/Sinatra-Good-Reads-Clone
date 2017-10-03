$(document).ready(function(){
  // fade out flash message following delay
  // $('.flash-message').delay(4000).fadeOut();

  // $('.flash-message-wrapper').hide();

  // enable drop down menu
  $('.ui.selection.dropdown').dropdown();

  // remove flash message on click
  $('a.close').click(function(e){
    e.preventDefault();
    $(this).parent().hide();
  })

  var forms = document.querySelectorAll('li.book-wrap form');
  forms.forEach(function(form, i){
    $(form).submit(function(e){
      e.preventDefault();
      var goodreads_id = $(form).find('input[name="goodreads_id"]').val();
      var formData = $(form).serialize();

      $.ajax({
        type: "POST",
        url: $(form).attr('action'),
        data: formData,
        success: function(response){
          var vals = response.split('-')
          if (vals[0] == goodreads_id) {
            $(".message-" + goodreads_id).show();
            $(".flash-message").html(vals[1])
          }
        },
        error: function(response){
          if (response[0] == goodreads_id) {
            // TODO
          }
        }
      });
    });

  });

});
