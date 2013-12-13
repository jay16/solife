class CreateOrgsMails < ActiveRecord::Migration
  def change
    create_table :orgs_mails do |t|
      t.integer :mailer_id
      t.integer :maillist_id

      t.timestamps
    end
  end
end
