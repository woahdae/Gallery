require_relative '../minitest_helper'

describe Cart do
  subject { Factory.build(:cart) }

  describe 'validation' do
    it 'passes given a valid object' do
      subject.must_be :valid?
    end

    it 'fails if a promo cant be found for a given code' do
      subject.promo_code = '123ABC'
      subject.valid?
      subject.errors[:promo_code].must_be :present?
    end

    it 'fails if a promo isnt valid for use' do
      Factory.create(:promo, code: '123ABC', expires_on: Date.yesterday)

      subject.promo_code = '123ABC'
      subject.valid?
      subject.errors[:promo_code].must_be :present?
    end
  end

  describe '#promo_discount' do
    it 'is 0 when no promo is present' do
      subject.promo_discount.must_equal 0
    end

    it 'is reflective of the promo fixed_discount and percentage_discount' do
      promo = Factory.build(:promo,
                            fixed_discount:      1.00,
                            percentage_discount: 25)

      subject.line_items = [Factory.build(:line_item, size: 'small')]
      subject.promo = promo
      # $1 off + (($5 - $1) * .25) = $2 off
      subject.promo_discount.must_equal 2.0
    end
  end
end
