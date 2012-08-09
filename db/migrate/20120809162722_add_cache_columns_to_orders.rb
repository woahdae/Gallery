class AddCacheColumnsToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :buyer_email, :string
    add_column :orders, :line_items_count, :integer
    add_column :orders, :total, :decimal, :precision => 8, :scale => 2
    add_column :orders, :payment_status, :string

    Order.find_each(&:save)
  end
end
