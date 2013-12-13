class CreateReplies < ActiveRecord::Migration
  def change
    create_table :replies do |t|
      t.integer :segment_id
      t.integer :reply_id
      t.string :name
      t.string :email
      t.text :content

      t.timestamps
    end
  end
end
