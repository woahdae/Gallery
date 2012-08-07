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

  # Allow nil just for testing purposes
  delegate :payment_status, to: :paypal_receipt, :allow_nil => true

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

  def to_zip
    t = Tempfile.new([self.uuid, '.zip'])

    Zip::ZipOutputStream.open(t.path) do |zip|
      line_items.each do |li|
        zip.put_next_entry(File.join(self.uuid, li.photo.image_file_name))
        zip.print(li.download_object.read)
      end
    end

    t
  end

  def to_param
    "#{id}-#{uuid}"
  end
end
