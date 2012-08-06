$(function() {
  if (!$('body').hasClass('albums')) return;

  $('li.thumbnail').colorbox({
    rel: 'thumbnail',
    inline: true,
    photo: true,
    href: function() {
      return $(this).find('a.photo-link').attr('href')
    }
  });

  $('body').on('ajax:success', '.purchase-options a', function(_, doc) {
    doc = eval(doc) // take away outer quotes; probably a better way...
    var hasCart = !!$('#cart').html().trim();
    if (!hasCart) {
      elem = $(doc)
      elem.hide();
      $('#cart').replaceWith(elem);
      elem.fadeIn(1000);
    }
    $('.cart-flash').show().delay(1000).fadeOut();
  });
})
