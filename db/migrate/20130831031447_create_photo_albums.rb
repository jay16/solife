class CreatePhotoAlbums < ActiveRecord::Migration
  def change
    create_table :photo_albums do |t|
      t.integer :photo_id
      t.integer :folder_id

      t.timestamps
    end
  end
end
