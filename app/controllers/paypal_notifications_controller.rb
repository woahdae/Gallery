require 'net/http'

class PaypalNotificationsController < ApplicationController
  def pdt
    pdt_data = PaypalPdt.new(params).postback!

    receipt = PaypalReceipt.create!(:params => pdt_data,
                                    :uuid   => pdt_data['invoice'])

    user = User.find_or_create_by_email!(pdt_data['payer_email'],
      :password              => pass = 16.times.map{rand(9)}.join,
      :password_confirmation => pass)

    order = Order.transfer_cart(Cart.find_by_uuid(receipt.uuid), user)

    sign_in(user)

    redirect_to(order)
  end
end
