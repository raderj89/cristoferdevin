$ ->
  $('a.load-more-products').on 'inview', (e, visible) ->
    return unless visible
    
    $.getScript $(this).attr('href')