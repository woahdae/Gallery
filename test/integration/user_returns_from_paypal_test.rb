require_relative '../minitest_helper'

class UserReturnsFromPaypalTest < IntegrationTest
  # Defined in paypal_pdt cassette. Don't want to go full erb cassette
  # just to inject this...
  TEST_ATTRS = {
    invoice:     'd21d994a0c0cff803',
    payer_email: 'buyer_1343845372_per@gmail.com' }

  let(:cart)   {
    Factory.create(:cart,
                   :uuid => TEST_ATTRS[:invoice],
                   :line_items => [line_item1, line_item2]) }

  let(:line_item1) { Factory.create(:line_item, :photo => photo1) }
  let(:line_item2) { Factory.create(:line_item, :photo => photo2) }
  let(:line_item3) { Factory.create(:line_item, :photo => photo3) }

  let(:photo1) { Factory.create(:photo) }
  let(:photo2) { Factory.create(:photo) }
  let(:photo3) { Factory.create(:photo) }

  let(:pdt_params) do
    { 'tx'          => '4RU29511G17214419',
      'st'          => 'Completed',
      'amt'         => '30.00',
      'cc'          => 'USD',
      'cm'          => '',
      'item_number' => '' }
  end

  before do
    cart # create it

    # paypal just redirects back to us with some params
    visit "/paypal_notifications/pdt?#{pdt_params.to_query}"
  end

  it 'creates an order from the cart', vcr: 'paypal_pdt' do
    order = Order.last
    cart.line_items.sort.must_equal order.line_items.sort
  end

  it 'creates an account if it doesnt exist', vcr: 'paypal_pdt' do
    user = User.last
    user.email.must_equal TEST_ATTRS[:payer_email]
  end

  it 'logs the user in to their account if not logged in', vcr: 'paypal_pdt' do
    user = User.last
    page.must have_content("Logged in as #{user.display_name}")
  end

  it 'redirects the logged-in user to their newly created order',
    vcr: 'paypal_pdt' do
    order = Order.last
    page.current_url.must equal_url(url_for(order))
  end
end
