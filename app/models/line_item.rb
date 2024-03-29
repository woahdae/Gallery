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

  def download_url
    read_attribute(:download_url) || generate_download_url
  end

  private

  def generate_download_url
    s3_object = if size == 'large'
      photo.image.s3_object(:original)
    else
      photo.image.s3_object("purchase_#{size}")
    end

    url = s3_object.url_for(:read,
      :expires                      => 6.days.from_now.midnight,
      :response_content_disposition => 'attachment',
      :response_content_type        => 'application/force-download').to_s

    self.download_url = url
    save!

    url
  end
end
