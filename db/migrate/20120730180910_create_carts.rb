class CreateCarts < ActiveRecord::Migration
  def change
    create_table :carts do |t|
      t.string :session_id

      t.timestamps
    end

    add_index :carts, :session_id
  end
end
