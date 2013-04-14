require_relative '../minitest_helper'

describe Album do
  describe 'validation' do
    subject { Factory.build(:album) }

    it 'passes given a valid album' do
      subject.must_be(:valid?)
    end

    it 'fails given a blank name' do
      subject.name = ''
      subject.wont_be(:valid?)
    end
  end
end
