class LineItem < ActiveRecord::Base
  belongs_to :cart, :inverse_of => :line_items
  belongs_to :photo
end
