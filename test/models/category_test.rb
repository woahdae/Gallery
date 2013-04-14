require_relative '../minitest_helper'

describe Category do
  describe 'validation' do
    subject { Factory.build(:category) }

    it 'passes given a valid category' do
      subject.must_be(:valid?)
    end

    it 'fails given a blank name' do
      subject.name = ''
      subject.wont_be(:valid?)
    end
  end
end
