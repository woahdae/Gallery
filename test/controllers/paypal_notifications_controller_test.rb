require_relative '../minitest_helper'

describe PaypalNotificationsController do
  it 'echoes the transaction id plus our token back to paypal' do
    params = {
      'tx'          => '4RU29511G17214419',
      'st'          => 'Completed',
      'amt'         => '30.00',
      'cc'          => 'USD',
      'cm'          => '',
      'item_number' => ''
    }

    get :show, params

    response.must_be_redirect
  end

  describe 'on success' do
    it 'creates a receipt of payment'
    it 'creates an order from the cart'
    it 'creates an account if it doesnt exist'
    it 'logs the user in to their account if not logged in'
    it 'redirects the logged-in user to their newly created order'
  end
end

