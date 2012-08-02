class LineItem < ActiveRecord::Base
  belongs_to :cart, :inverse_of => :line_items
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
end
