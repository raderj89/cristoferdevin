$(function() {
  if($("body").hasClass("admin/products_index")) {
    // Make Product Featured
    $("input.featured").on("change", function() {
      $this = $(this)
      $.post("/admin/products/feature", { id: $this.attr('id'), category: $this.data().category });
    })
  }

}) // end doc ready