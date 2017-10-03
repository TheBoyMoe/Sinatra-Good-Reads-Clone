$(document).ready(function(){
  // fade out flash message following delay
  // $('.flash-message').delay(4000).fadeOut();

  $('.flash-message-wrapper').hide();

  // enable drop down menu
  $('.ui.selection.dropdown').dropdown();

  // remove flash message on click
  $('a.close').click(function(e){
    e.preventDefault();
    $(this).parent().remove();
  })

  var forms = document.querySelectorAll('li.book-wrap form');
  forms.forEach(function(form){
    $(form).submit(function(e){
      e.preventDefault();
      var formData = $(form).serialize();

      $.ajax({
        type: "POST",
        url: $(form).attr('action'),
        data: formData,
        success: function(){
          $('.flash-message-wrapper').show();
          $(".flash-message").html("Book successfully saved")
        },
        error: function(){
          $('.flash-message-wrapper').show();
          $(".flash-message").html("Error saving book")
        }
      });
    });

  });

  // submit form data and stay on the same page
  // var form = $(".save-book-form");
});
