$(function() {
  if($("body").hasClass("carts_show")) {
    // update order item quantity on blur
    $('td.quantity').on("keyup", 'input', function() {
      // quantity table
      var $this = $(this);

      // ordered item ID
      var itemId = $this.parent().data('itemId')

      // new quantity
      var newQuantity = $this.val();
      
      // update quantity ajax request
      $.ajax({
        url: '/ordered_items/' + itemId,
        type: 'PUT',
        data: { item_id: itemId, quantity: newQuantity }
      }).done(function(res) {
          // update item price & subtotal in view
          
          // price field
          var priceField = $this.parent().next();
          
          // subtotal field
          var subtotal = $('.subtotal p span');
          
          priceField.text("$" + parseInt(res.itemPrice).toFixed(0));
          subtotal.text("$" + parseInt(res.subtotal).toFixed(2));
      })
    }) // end blur event listener


    // remove item from cart on click
    $('.js-remove_from_order').on('click', function(e) {
      var $this = $(this);
      var itemId = $this.data('item-id');

      $.ajax({
        url: '/ordered_items/' + itemId,
        type: 'DELETE',
        data: {item_id: itemId }
      }).done(function(response){
        $this.closest('tr').remove();
        $('.number').html(response.order_total)
      })
    }) // end click event listener
  } // end if statement
}) // end doc ready
