class Cart < ActiveRecord::Base
  has_many :line_items,
    :inverse_of => :cart,
    :dependent => :destroy

  has_many :photos, :through => :line_items

  def add(photo_id, options)
    return if line_items.find_by_photo_id(photo_id)

    line_items.build(options).tap do |li|
      li.photo_id = photo_id
    end.save!
  end

  def remove(photo_id)
    line_items.delete(LineItem.find_by_photo_id(photo_id))
  end

  before_create :generate_uuid

  private

  def generate_uuid
    # http://stackoverflow.com/questions/1117584/guids-in-ruby
    self.uuid = (0..16).to_a.map{|a| rand(16).to_s(16)}.join
  end
end
