class CreateConsumeTags < ActiveRecord::Migration
  def change
    create_table :consume_tags do |t|
      t.integer :consume_id
      t.integer :tag_id

      t.timestamps
    end
  end
end
