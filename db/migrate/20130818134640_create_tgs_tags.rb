class CreateTgsTags < ActiveRecord::Migration
  def change
    create_table :tgs_tags do |t|
      t.integer :taggroup_id
      t.integer :tag_id

      t.timestamps
    end
  end
end
