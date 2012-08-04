class PaypalReceipt < ActiveRecord::Base
  attr_accessible :params, :uuid
  serialize :params, JSON
end
