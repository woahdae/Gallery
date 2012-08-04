require_relative '../minitest_helper'

class UserSubmitsCartToPaypalTest < IntegrationTest
  let(:photo1) { Factory.create(:photo) }
  let(:photo2) { Factory.create(:photo) }
  let(:photo3) { Factory.create(:photo) }

  let(:cart)   {
    # awkward way of getting the cart w/ correct session id
    visit cart_path
    Cart.last }

  before do
    cart.add(photo1, :size => 'small')
  end

  it 'user goes to paypal to pay for their cart' do
    visit cart_path

    # all we can really do is make sure there is a link on the page with
    # the right parameters

    page.find('a#paypal-checkout')['href'].must_equal(
      PaypalPayment.new(cart, with: :size).checkout_url)
  end
end

