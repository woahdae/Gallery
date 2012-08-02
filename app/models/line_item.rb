class LineItem < ActiveRecord::Base
  belongs_to :cart, :inverse_of => :line_items
  belongs_to :photo

  # Doing this out of habit for paypal integration, considering
  # we might want to sell prints at some point
  def qty
    1
  end

  def unit_price
    BigDecimal.new('2.0')
  end
end
