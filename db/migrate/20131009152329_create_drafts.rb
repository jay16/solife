class CreateDrafts < ActiveRecord::Migration
  def change
    create_table :drafts do |t|
      t.integer :segment_id
      t.text :content

      t.timestamps
    end
  end
end
