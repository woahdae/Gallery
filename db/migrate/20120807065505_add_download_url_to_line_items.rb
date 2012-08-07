class AddDownloadUrlToLineItems < ActiveRecord::Migration
  def change
    add_column :line_items, :download_url, :text
    remove_column :orders, :download_url
  end
end
