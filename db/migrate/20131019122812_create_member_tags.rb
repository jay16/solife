class CreateMemberTags < ActiveRecord::Migration
  def change
    create_table :member_tags do |t|
      t.integer :member_id
      t.integer :tag_id

      t.timestamps
    end
  end
end
