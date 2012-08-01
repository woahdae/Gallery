class CreateLineItems < ActiveRecord::Migration
  def change
    create_table :line_items do |t|
      t.integer :cart_id
      t.integer :photo_id

      t.timestamps
    end

    add_index :line_items, :cart_id
    add_index :line_items, :photo_id
  end
end
