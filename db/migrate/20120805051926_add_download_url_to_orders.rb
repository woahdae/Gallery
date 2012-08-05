class AddDownloadUrlToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :download_url, :string
  end
end
