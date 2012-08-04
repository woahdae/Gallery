class PaypalPayment
  attr_reader :cart, :with

  def initialize(cart, options = {})
    @cart = cart
    @with = options[:with] || []
  end

  def checkout_params
    values = {
      :business => Gallery.settings.paypal.email,
      :cmd      => "_cart",
      :upload   => 1,
      :return   => "http://#{Gallery.settings.domain}/paypal_notifications/pdt",
      :invoice  => cart.uuid
    }

    cart.line_items.each_with_index do |item, index|
      index = index + 1
      values.merge!({
        "amount_#{index}"      => item.unit_price,
        "item_name_#{index}"   => item.photo.image_file_name,
        "item_number_#{index}" => item.photo.id,
        "quantity_#{index}"    => item.qty
      })

      Array(with).each_with_index do |attr, option_index|
        values.merge!({
          "on#{option_index}_#{index}" => attr.to_s,
          "os#{option_index}_#{index}" => item.send(attr),
        })
      end
    end

    values
  end

  def checkout_url
    Gallery.settings.paypal.endpoint + '?' + checkout_params.to_param
  end
end
