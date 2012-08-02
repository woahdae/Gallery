$(function() {
  if (!$('body').hasClass('alblums')) return;

  $('a.thumbnail').colorbox({rel: 'thumbnail'});

  $('i.cart').on('click', function(e) {
    e.preventDefault();
    e.stopPropagation();

    $.ajax('/cart/add?photo_id=' + $(this).data().photoId, {
      type: 'POST',
      dataType: 'html',
      success: function(document) {
        var hasCart = !!$('#cart').html().trim();
        if (hasCart) {
          $('#cart').replaceWith(document);
          prevColor = $('.cart-title').css('color');
          $('.cart-title').animate({color: '#111'}).animate({color: prevColor});
        } else {
          elem = $(document)
          elem.hide();
          $('#cart').replaceWith(elem);
          elem.fadeIn(1000);
        }
      }
    });

    return false;
  })
})
