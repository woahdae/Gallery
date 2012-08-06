class LineItem < ActiveRecord::Base
  belongs_to :cart, :inverse_of => :line_items
  belongs_to :order, :inverse_of => :line_items
  belongs_to :photo

  attr_accessible :size

  SIZES = ['small', 'medium', 'large']

  PRICES = {
    'small'  => 5,
    'medium' => 10,
    'large'  => 15,
  }

  validates :size,
    :presence  => true,
    :inclusion => {:in => SIZES}

  # Doing this out of habit for paypal integration, considering
  # we might want to sell prints at some point
  def qty
    1
  end

  def unit_price
    PRICES[size]
  end

  def public_photo_url
    photo.image(size)
  end

  def download_object
    if size == 'large'
      li.photo.image.s3_object(:original).read
    else
      li.photo.image.s3_object("purchase_#{size}").read
    end
  end
end
