class RenameAlbumsToCategories < ActiveRecord::Migration
  def change
    rename_table :albums, :categories
    add_column :categories, :ancestry, :string
    add_index :categories, :ancestry

    rename_column :photos, :album_id, :category_id
    rename_index :photos, 'index_photos_on_alblum_id', 'index_photos_on_category_id'
  end
end
