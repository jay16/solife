class CreateInboxes < ActiveRecord::Migration
  def change
    create_table :mail_inboxes do |t|
      t.text :mail_orgstr
      t.string :mail_from
      t.string :mail_to
      t.string :mail_sender
      t.string :mail_subject
      t.string :mail_date
      t.string :mail_message_id
      t.text :mail_body
      t.string :mail_cc
      t.integer :maillist_id
      t.integer :inbox_type

      t.timestamps
    end
  end
end
