require_relative '../minitest_helper'

class UserAddsPhotosToCartTest < IntegrationTest
  let(:category) { Factory.create(:category,
                                :photos => [photo1, photo2, photo3]) }
  let(:photo1) { Factory.create(:photo) }
  let(:photo2) { Factory.create(:photo) }
  let(:photo3) { Factory.create(:photo) }

  before { category }

  it 'user adds a photo to their cart' do
    visit root_path

    last_cart = Cart.last

    within(css_id(photo1)) { find('a.image-small').click }

    cart = Cart.last
    # sanity check
    cart.wont_equal last_cart

    cart.line_items.first.photo.must_equal photo1
  end
end
