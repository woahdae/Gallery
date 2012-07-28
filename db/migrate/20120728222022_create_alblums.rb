class CreateAlblums < ActiveRecord::Migration
  def change
    create_table :alblums do |t|
      t.string :name
      t.integer :user_id

      t.timestamps
    end

    add_index :alblums, :user_id
  end
end
