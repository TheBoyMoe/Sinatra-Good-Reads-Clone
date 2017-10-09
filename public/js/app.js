$(document).ready(function(){
  // fade out flash message following delay
  // $('.flash-message').delay(4000).fadeOut();

  // $('.flash-message-wrapper').hide();

  // enable drop down menu
  $('.ui.selection.dropdown').dropdown();

  // enable Tabs
  $('.tabular.menu .item').tab();

  // remove flash message on click
  $('a.close').click(function(e){
    e.preventDefault();
    $(this).parent().hide();
  })

  // handle saving books to the appropriate book shelf
  var forms = document.querySelectorAll('li.book form');
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
            $(".flash-message").html(vals[1]);
          }
        },
        error: function(response){
          console.log("failure: ", response);
        }
      });
    });

  });

  // handle posting a book review to the review's controller
  var review-form = document.getElementById('review-form')
  $(review-form).submit(function(e){
    e.preventDefault();
    var formData = $(review-form).serialize();
    $.ajax({
      type: 'POST',
      url: $(review-form).attr('action'),
      data: formData,
      success: function(response){
        $('.book-review').html(response);
      },
      error: function(response){
        console.log("Error submitting book review", response);
      }
    });
  })

});
