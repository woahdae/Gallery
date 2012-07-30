class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.integer :alblum_id

      t.timestamps
    end

    add_index :photos, :alblum_id
  end
end
