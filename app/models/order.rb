require 'zip/zip'

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
        Gallery::Jobs.zip_order << {order_id: order.id}
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
