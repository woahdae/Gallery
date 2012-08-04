class Order < ActiveRecord::Base
  belongs_to :user, :inverse_of => :orders
  has_many :line_items, :inverse_of => :order
  attr_protected :uuid, :user_id

  def self.transfer_cart(cart, user)
    create!.tap do |order|
      order.uuid = cart.uuid
      order.user = user
      order.line_items = cart.line_items
      if order.save
        cart.destroy
      end
    end
  end

  def total
    line_items.to_a.sum(&:unit_price)
  end
end
