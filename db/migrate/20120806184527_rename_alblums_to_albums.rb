class RenameAlblumsToAlbums < ActiveRecord::Migration
  def change
    rename_table :alblums, :albums
    rename_column :photos, :alblum_id, :album_id
  end
end
