require_relative "../minitest_helper"

describe Promo do
  subject { Factory.build(:promo) }

  describe 'validation' do
    it "passes when promo is a valid object" do
      subject.must_be :valid?
    end

    it 'fails when code is blank' do
      subject.code = ''
      subject.must_be :invalid?
    end

    it 'fails when expires_on is blank' do
      subject.expires_on = ''
      subject.must_be :invalid?
    end

    it 'fails when expires_on is in the past' do
      subject.expires_on = Date.yesterday
      subject.must_be :invalid?, :use
    end

    it 'fails when both fixed_discount and percentage_discount are blank' do
      subject.fixed_discount = ''
      subject.percentage_discount = ''
      subject.must_be :invalid?
    end
  end
end
