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

  describe 'slug' do
    it 'is unique within its parent category' do
      first_foo  = Factory(:category, name: 'foo')
      second_foo = Factory(:category, name: 'foo')
      first_bar  = Factory(:category, name: 'bar')
      second_bar = Factory(:category, name: 'bar', parent: first_bar)

      second_foo.slug.must_equal 'foo--2'
      second_bar.slug.must_equal 'bar'
    end
  end
end
