class CreateSites < ActiveRecord::Migration
  def change
    create_table :sites do |t|
      t.integer :favority_id
      t.string :name
      t.string :url
      t.string :desc
      t.string :logo

      t.timestamps
    end
  end
end
