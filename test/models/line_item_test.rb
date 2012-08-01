require "minitest_helper"

describe LineItem do
  before do
    @line_item = LineItem.new
  end

  it "must be valid" do
    @line_item.valid?.must_equal true
  end
end
