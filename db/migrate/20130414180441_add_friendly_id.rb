class AddFriendlyId < ActiveRecord::Migration
  class Category < ActiveRecord::Base
    extend FriendlyId
    friendly_id :name, use: [:slugged, :scoped], scope: :ancestry
  end

  def change
    add_column :categories, :slug, :string
    add_index :categories, :slug

    Category.find_each(&:save)
  end
end
