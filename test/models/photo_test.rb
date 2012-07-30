require "minitest_helper"

describe Photo do
  before do
    @photo = Photo.new
  end

  it "must be valid" do
    @photo.valid?.must_equal true
  end
end
