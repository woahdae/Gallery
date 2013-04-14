class RenameAlbumsToCategories < ActiveRecord::Migration
  def change
    rename_table :albums, :categories
    add_column :categories, :ancestry, :string
    add_index :categories, :ancestry
  end
end
