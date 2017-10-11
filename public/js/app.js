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
  var reviewForm = document.querySelector('#review-form');
  $(reviewForm).submit(function(e){
    e.preventDefault();
    var formData = $(reviewForm).serialize();
    $.ajax({
      type: 'POST',
      url: $(reviewForm).attr('action'),
      data: formData,
      success: function(response){
        var values = response.split(' / ');
        var review = values[0];
        var username = values[1];
        var review_url = values[2];
        var timestamp = values[3];
        html =
        '<div class="user-review"><div class="review-edit-button clearfix"><a class="ui button right" href="/reviews/' + review_url + '/edit">edit review</a></div><h3 class="review-author">' + username + '&nbsp;<span class="review-timestamp">' + timestamp + '</span></h3><p class="book-review">' + review + '</p></div>'

        $('#review-form-container').after(html);
        $('#review-form-container').remove();
        $('#user-message').remove();
      },
      error: function(response){
        console.log("Error submitting book review", response);
      }
    });
  })


  // accordian effect on add review form
  $('.ui.accordion')
    .accordion()
  ;

  // display review edit form through modal
  $('.ui.modal')
    .modal('attach events', '.edit-review-trigger', 'show')
  ;

  $('.edit-review-trigger').click(function(e){
    e.preventDefault();
  })

});
