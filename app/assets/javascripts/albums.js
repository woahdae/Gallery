$(function() {
  if (!$('body').hasClass('albums')) return;

  $('li.thumbnail').colorbox({
    rel: 'thumbnail',
    href: function() {
      return $(this).find('a.photo-link').attr('href')
    }
  });

  // Prevent the click from going to the colorbox
  $('.download form').click(function(e) {e.stopPropagation()})

  $('body').on('ajax:success', '.download form', function(_, doc) {
    doc = eval(doc) // take away outer quotes; probably a better way...
    var hasCart = !!$('#cart').html().trim();
    if (hasCart) {
      $('#cart').replaceWith(doc);
      prevColor = $('.cart-title').css('color');
      $('.cart-title').animate({color: '#111'}).animate({color: prevColor});
    } else {
      elem = $(doc)
      elem.hide();
      $('#cart').replaceWith(elem);
      elem.fadeIn(1000);
    }
  });
})
