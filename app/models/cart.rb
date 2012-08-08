class Cart < ActiveRecord::Base
  has_many :line_items,
    :inverse_of => :cart

  has_many :photos, :through => :line_items

  def add(photo_id, line_item_attrs = {})
    return if line_items.find_by_photo_id(photo_id)

    line_items.build(line_item_attrs).tap do |li|
      li.photo_id = photo_id
    end.save!
  end

  def remove(photo_id)
    line_items.find_by_photo_id(photo_id).delete
  end

  before_create :generate_uuid

  def total
    line_items.to_a.sum(&:unit_price)
  end

  private

  def generate_uuid
    # http://stackoverflow.com/questions/1117584/guids-in-ruby
    self.uuid ||= (0..16).to_a.map{|a| rand(16).to_s(16)}.join
  end
end
