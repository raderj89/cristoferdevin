$(function(){
  // Only in product show page
  if ($(".product-show")[0]) {

    // Show Product Details, Hide product details
    $('.js-show-product-details').click(function(e){
      e.preventDefault();
      $('.product-description').hide();
      $('.product-details').fadeIn();
    });

    // Show product description, hide product details
    $('.js-show-product-description').click(function(e){
      e.preventDefault();
      $('.product-details').hide();
      $('.product-description').fadeIn();
    });

    // Show image when thumbnail clicked
    $('ul.thumbnails li').click(function(){
      var $clickedImgSrc = $(this).children()[0].src;
      var $largeImage = $('.large-image')[0]

      // Replace large image source with source of thumbnail
      $largeImage.src = $clickedImgSrc

      // Remove old magnifying lens
      $(".mlens_boss").remove();
      // Create new magnifying lens
      lensZoom();
    });

    // Add Item to Cart
    $("form.new_ordered_item").on("submit", function(e) {
      e.preventDefault();
      $this = $(this);
      var productId = $this.find('#ordered_item_product_id').val();
      var quantity = $this.find('#ordered_item_quantity').val();

      // Add grayed out overlay
      var docHeight = $(document).height();
      $("body").append("<div id='gray-overlay'></div>");


      $("#gray-overlay")
        .height(docHeight)
        .css({
           'opacity' : 0.7,
           'position': 'absolute',
           'top': 0,
           'left': 0,
           'background-color': '#DAD8D9',
           'width': '100%',
           'z-index': 200
      });

      $("#gray-overlay").fadeIn(200);

      // Post to new ordered item controller
      $.post('/ordered_items', {product_id: productId, quantity: quantity} )
        .done(function(response) {
          var orderedItemQuantity = parseInt($('#ordered_item_quantity').val());
          var currentNumItems = parseInt($('.shopping-link span').text());
          var newNumItems = orderedItemQuantity + currentNumItems;

          $(".shopping-bag").html(response);

          $('.shopping-link span').html(newNumItems);
        })

      // Close modal and hide overlay when X is clicked
      $('.shopping-bag').on('click', '.js-close-modal', function(e){
        e.preventDefault();
        $('#gray-overlay').fadeOut(200);
        $('.order').fadeOut(200);
      })

    }) // end add to cart submit

    // Zoom functionality on product image

    function lensZoom(){
      $('.large-image').mlens({
        zoomLevel: 1,
        lensSize: 300,
        lensShape: "square",
        borderSize: 0,
        position: "absolute",
      });
    };    

    lensZoom();

  }; // end product show page JS
})