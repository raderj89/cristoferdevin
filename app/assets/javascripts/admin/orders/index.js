$(function() {
  if($("body").hasClass("admin/orders_index")) {

    // shipped order checkbox updates order status
    $("input.shipped").on("change", function(e) {
      var $this = $(this);
      $.post("/orders/order_shipped", { order_id: $this.attr('id') });
    })

    // order received checkbox updates order status
    

    // cancel order check box updates order status
    $("input.cancel").on("change", function() {
      var $this = $(this);
      $.post("/orders/cancel", { order_id: $this.attr('id') });
    })
    
  } // end if statement
}) // end doc ready