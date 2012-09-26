class CreatePromos < ActiveRecord::Migration
  def change
    create_table :promos do |t|
      t.decimal :fixed_discount, precision: 8, scale: 2
      t.integer :percentage_discount
      t.string :code
      t.date :expires_on

      t.timestamps
    end

    add_column :carts, :promo_id, :integer

    add_column :orders, :promo_id, :integer
    add_column :orders, :promo_discount, :decimal, precision: 8, scale: 2

    add_index :promos, :code
  end
end
