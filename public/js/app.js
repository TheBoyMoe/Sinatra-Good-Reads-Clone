$(document).ready(function(){
  // fade out flash message following delay
  // $('.flash-message').delay(4000).fadeOut();

  // remove flash message on click
  $('a.close').click(function(){
    $(this).parent().remove();
  })
  // enable drop down menu
  $('.ui.selection.dropdown').dropdown();
});
