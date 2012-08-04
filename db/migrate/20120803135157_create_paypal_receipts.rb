class CreatePaypalReceipts < ActiveRecord::Migration
  def change
    create_table :paypal_receipts do |t|
      t.text :params
      t.string :uuid

      t.timestamps
    end
  end
end
