require "minitest_helper"

describe Cart do
  before do
    @cart = Cart.new
  end

  it "must be valid" do
    @cart.valid?.must_equal true
  end
end
