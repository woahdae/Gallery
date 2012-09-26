class Promo < ActiveRecord::Base
  attr_accessible :code, :expires_on, :fixed_discount, :percentage_discount

  validates :code, presence: true
  validates :expires_on, presence: true
  validate :validate_fixed_or_percentage_discount

  validates :expires_on, on: :use,
    date: {after_or_equal_to: proc { Date.today }}

  def fixed_discount
    read_attribute(:fixed_discount) || 0.0
  end

  def percentage_discount
    read_attribute(:percentage_discount) || 0
  end

  private

  def validate_fixed_or_percentage_discount
    if fixed_discount == 0.0 && percentage_discount == 0
      errors.add(:base, 'either fixed or percentage discount is required')
    end
  end
end
