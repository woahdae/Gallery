class CreateCarouselPhotos < ActiveRecord::Migration
  def change
    create_table :carousel_photos do |t|
      t.integer :photo_id
      t.integer :position

      t.timestamps
    end
  end
end
