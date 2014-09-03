$(function() {
  if($("ul#categories")) {
    $('ul#categories').sortable({
      axis: 'y',
      containment: "parent",
      forceHelperSize: true,
      forcePlaceholderSize: true,
      update: function() {
        $.post($(this).data('update-url'), $(this).sortable('serialize'))
          .done(function(resp) {
            console.log(resp)
          })
      }
    });
  }
}) // end doc ready