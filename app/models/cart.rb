class Cart < ActiveRecord::Base
  has_many :line_items, :inverse_of => :cart
  has_many :photos, :through => :line_items
  belongs_to :promo

  before_create :generate_uuid

  attr_accessible :promo_code

  attr_accessor :promo_code

  validate :validate_promo_use, if: lambda { promo_code.present? }

  def add(photo_id, line_item_attrs = {})
    return if line_items.find_by_photo_id(photo_id)

    line_items.build(line_item_attrs).tap do |li|
      li.photo_id = photo_id
    end.save!
  end

  def remove(photo_id)
    line_items.find_by_photo_id(photo_id).delete
  end

  def total
    [total_before_promo - promo_discount, 0].max
  end

  def total_before_promo
    line_items.to_a.sum(&:unit_price)
  end

  def promo_discount
    return 0.0 if !promo

    total_before_percent_discount = total_before_promo - promo.fixed_discount

    percent_discount = total_before_percent_discount *
      (promo.percentage_discount * 0.01)

    promo.fixed_discount + percent_discount
  end

  private

  def validate_promo_use
    promo = Promo.find_by_code(promo_code)
    if promo_code && promo.try(:valid?, :use)
      self.promo_id = promo.id
    else
      errors.add(:promo_code, 'is invalid')
    end
  end

  def generate_uuid
    # http://stackoverflow.com/questions/1117584/guids-in-ruby
    self.uuid ||= (0..16).to_a.map{|a| rand(16).to_s(16)}.join
  end
end
