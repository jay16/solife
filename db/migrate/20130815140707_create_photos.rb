class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :name
      t.string :orginal_name
      t.text :desc
      t.string :path

      t.timestamps
    end
  end
end
