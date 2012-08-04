class PaypalPdt
  def initialize(pdt_params)
    @pdt_params = pdt_params
  end

  def tx_id
    @pdt_params['tx']
  end

  def postback!
    postback_params = {
      "cmd"    => "_notify-synch",
      "tx"     => tx_id,
      "at"     => Gallery.settings.paypal.pdt_token,
      'commit' => 'PDT'
    }

    resp = RestClient.post(Gallery.settings.paypal.endpoint, postback_params).
      split("\n").map(&:strip)

    # see body of test/cassettes/paypal_pdt.yml for example response
    status = resp.shift
    params = resp.inject({}) do |acc, e|
      next if e.blank? # sandbox likes to double-space responses...

      e = e.split('=')
      acc[e[0]] = URI.decode(e[1] || '')
      acc
    end

    if status == 'SUCCESS'
      params
    else
      Rails.logger.info "Paypal PDT failure; "\
                        "tx: #{tx_id}, status: #{status}, params: #{params}"
      raise "Paypal PDT Failure for tx #{tx_id}"
    end
  end
end
