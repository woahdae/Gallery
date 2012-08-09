require 'zip/zip'

class Order < ActiveRecord::Base
  belongs_to :user, :inverse_of => :orders
  belongs_to :paypal_receipt, :foreign_key => :uuid, :primary_key => :uuid,
    :inverse_of => :order
  has_many :line_items, :inverse_of => :order
  attr_protected :uuid, :user_id

  validates :uuid, presence: true
  validates :user, presence: true
  validates :line_items, length: {minimum: 1}

  before_save :cache_order_details

  def self.transfer_cart(cart, user)
    new.tap do |order|
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

  def to_param
    "#{id}-#{uuid}"
  end

  private

  def cache_order_details
    self.line_items_count ||= line_items.count
    self.payment_status   ||= paypal_receipt.try(:payment_status)
    self.buyer_email      ||= user.email
    self.total            ||= line_items.to_a.sum(&:unit_price)
  end
end
