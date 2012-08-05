require Rails.root + 'lib/girl_friday_ar_store'

class Gallery::Jobs
  class << self
    def default_options
      { :pool_size => 1,
        :store     => GirlFridayArStore }
    end

    # msg needs to be {:order_id => [order id]}
    def zip_order
      @email ||= GirlFriday::WorkQueue.new('zip_order', default_options) do |msg|
        order = Order.find(msg[:order_id])
        if order.download_url.nil?
          order.update_attributes(:download_url => 'generating')
          ZipAndUploadOrder.new(order).call
        end
      end
    end
  end
end
