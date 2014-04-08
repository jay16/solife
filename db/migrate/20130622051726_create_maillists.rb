class CreateMaillists < ActiveRecord::Migration
  def change
    create_table :maillists do |t|
      t.string :domain
      t.string :email_name
      t.string :email_pwd
      t.string :email_smtp
      t.string :smtp_port
      t.string :login_name
      t.string :email_pop
      t.string :pop_port
      t.integer :mailer_id
      t.boolean :is_valid
      t.string :unvalid
      t.integer :sign_index

      t.timestamps
    end
  end
end
