class Cart < ActiveRecord::Base
  has_many :line_items,
    :inverse_of => :cart,
    :dependent => :destroy

  has_many :photos, :through => :line_items

  def add(photo_id)
    return if line_items.find_by_photo_id(photo_id)

    line_items.build.tap do |li|
      li.photo_id = photo_id
    end.save!
  end

  def remove(photo_id)
    line_items.delete(LineItem.find_by_photo_id(photo_id))
  end
end
