class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string  :label
      t.integer :tag_type
      t.integer :user_id
      t.string  :p_id

      t.timestamps
    end
  end
end
