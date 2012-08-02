class AddUuidToCarts < ActiveRecord::Migration
  def change
    add_column :carts, :uuid, :string
    add_index :carts, :uuid
  end
end
