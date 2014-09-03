$(function(){
  // Only functions in order check out page
  if($('.checkout-page')[0]) {

    // Updates shipping cost and total cost on radio select
    $('.shipping-method-container').on('click', '.js-select-shipping', function(){
      $shippingCost = $(this).find('.shipping-cost').text().trim();
      
      // Update shipping cost
      $('.js-shipping-cost-number').html($shippingCost);

      var shippingNumber = $('.js-shipping-cost-number').html().replace('$', '');
      // Get integer amounts based on data attributes
      var subtotal = parseInt($('.js-subtotal').data('subtotal'));
      var tax = $('.js-tax-cost-number').data('tax');

      if ($shippingCost === 'Free') {
        var shipping = 0;
      } else {
          var shipping = parseFloat(shippingNumber);
      }
      
      // Update total cost
      $('.js-order-total').html('$' + (subtotal + tax + shipping).toFixed(2));
    })

    // Credit Card Validation
    function getCardType (number) {            
      var re = new RegExp("^4");
      if (number.match(re) != null)
        return("visa");

      re = new RegExp("^(34|37)");
      if (number.match(re) != null)
        return("amex");

      re = new RegExp("^5[1-5]");
      if (number.match(re) != null)
        return("mastercard");

      re = new RegExp("^6011");
      if (number.match(re) != null)
        return("discover");

      return("");
    }

    // Highlight appropriate card
    function highlightCard (cardType) {
      switch (cardType) {
        case '':
          $('.visa, .mastercard, .amex, .discover').css('background-position', '0 0');
          break;

        case 'visa':
          $('.mastercard, .discover, .amex').css('background-position', '0 -38px');
          break;

        case 'mastercard':
          $('.visa, .amex, .discover').css('background-position', '0 -38px');
          break;

        case 'discover':
          $('.visa, .amex, .mastercard').css('background-position', '0 -38px');
          break;

        case 'amex':
          $('.visa, .mastercard, .discover').css('background-position', '0 -38px');
          break;
      }
    }

    // Check credit card type while user types in cc field
    $('#order_card_info_card_number').keyup(function(){
      var cardType = getCardType($(this).val());
      highlightCard(cardType);
    });

    // Show shipping fields when user clicks checkbox
    $('#different_shipping').on('click', function(){
      $('.js-shipping-container').slideToggle();
    })

  }
})