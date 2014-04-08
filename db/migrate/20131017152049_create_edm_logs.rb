class CreateEdmLogs < ActiveRecord::Migration
  def change
    create_table :edm_logs do |t|
      t.integer :edm_id
      t.string :email
      t.string :subject
      t.string :result
      t.datetime :begin
      t.float :duration
      t.string :ip
      t.string :method
      t.string :send_type

      t.timestamps
    end
  end
end
