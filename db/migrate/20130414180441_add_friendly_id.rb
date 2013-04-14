class AddFriendlyId < ActiveRecord::Migration
  def change
    add_column :categories, :slug, :string
    add_index :categories, :slug

    Category.find_each(&:save)
  end
end
