require_relative '../minitest_helper'

describe PaypalPdt do
  describe '#postback!' do
    TEST_ATTRS = {
      invoice:     'd21d994a0c0cff803',
      payer_email: 'buyer_1343845372_per@gmail.com' }

    let(:pdt_params) do
      { 'tx'          => '4RU29511G17214419',
        'st'          => 'Completed',
        'amt'         => '30.00',
        'cc'          => 'USD',
        'cm'          => '',
        'item_number' => '' }
    end

    it 'posts the initial params back to paypal to return full order data',
      :vcr => 'paypal_pdt' do

      params = PaypalPdt.new(pdt_params).postback!
      params['invoice'].must_equal TEST_ATTRS[:invoice]
      params['payer_email'].must_equal TEST_ATTRS[:payer_email]
    end
  end
end
