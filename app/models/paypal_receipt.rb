class PaypalReceipt < ActiveRecord::Base
  attr_accessible :params, :uuid
  serialize :params, JSON

  belongs_to :order, :foreign_key => :uuid, :primary_key => :uuid,
    :inverse_of => :paypal_receipt

  def payment_status
    params['payment_status']
  end
end
