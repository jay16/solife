class CreateReplyTags < ActiveRecord::Migration
  def change
    create_table :reply_tags do |t|
      t.integer :reply_id
      t.integer :tag_id

      t.timestamps
    end
  end
end
