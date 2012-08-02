class PaypalPayment
  attr_reader :cart

  def initialize(cart)
    @cart = cart
  end

  def checkout_params
    values = {
      :business => Gallery.settings.paypal.email,
      :cmd => "_cart",
      :upload => 1,
      :return => "http://#{Gallery.settings.domain}/paypal_standard",
      :invoice => cart.uuid
    }

    cart.line_items.each_with_index do |item, index|
      index = index + 1
      values.merge!({
        "amount_#{index}"      => item.unit_price,
        "item_name_#{index}"   => item.photo.image_file_name,
        "item_number_#{index}" => item.photo.id,
        "quantity_#{index}"    => item.qty
      })
    end

    values
  end

  def checkout_url
    endpoint + checkout_params.to_param
  end

  def endpoint
    if Gallery.settings.paypal.live
      "https://www.sandbox.paypal.com/cgi-bin/webscr?"
    else
      "https://www.sandbox.paypal.com/cgi-bin/webscr?"
    end
  end
end
