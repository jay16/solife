class CreateFolders < ActiveRecord::Migration
  def change
    create_table :folders do |t|
      t.string :name
      t.string :folder_name
      t.text :desc
      t.boolean :is_public

      t.timestamps
    end
  end
end
