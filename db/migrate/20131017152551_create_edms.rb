class CreateEdms < ActiveRecord::Migration
  def change
    create_table :edms do |t|
      t.string :name
      t.integer :template_id
      t.string :subject
      t.string :from
      t.string :from_email

      t.timestamps
    end
  end
end
