require_relative '../minitest_helper'

describe PaypalPdt do
  describe '#postback!' do
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
      params.must_equal {}
    end
  end
end
