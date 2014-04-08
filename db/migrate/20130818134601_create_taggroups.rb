class CreateTaggroups < ActiveRecord::Migration
  def change
    create_table :taggroups do |t|
      t.integer :tag_id
      t.string :label
      t.integer :isprivate
      t.integer :group_type

      t.timestamps
    end
  end
end
