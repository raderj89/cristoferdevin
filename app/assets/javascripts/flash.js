$(function(){
  if($('.alert')[0]) {
    $('.alert').hide().slideDown();
  }

  $('button.close').on('click', function(e){
    e.preventDefault();
    $('.alert').slideUp();
  })
})