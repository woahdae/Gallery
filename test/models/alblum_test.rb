require "minitest_helper"

describe Alblum do
  before do
    @alblum = Alblum.new
  end

  it "must be valid" do
    @alblum.valid?.must_equal true
  end
end
