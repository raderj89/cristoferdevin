$(function(){
  // Behavior only if product index
  if($(".product-index")[0]){

    // Display overlay on hover
    $('.products-wrapper').on('mouseenter', '.single-product-wrapper', function(){
      $(this).find('.overlay').fadeIn(200);
    }).on('mouseleave', '.single-product-wrapper', function(){
      $(this).find('.overlay').fadeOut(200);
    })
  
  }; // end if statement
  
}); // end doc ready