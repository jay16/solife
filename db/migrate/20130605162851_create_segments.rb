class CreateSegments < ActiveRecord::Migration
  def change
    create_table :segments do |t|
      t.integer :life_id
      t.string :title
      t.text :content
      t.text :markdown
      t.string :permlink

      t.timestamps
    end
  end
end
