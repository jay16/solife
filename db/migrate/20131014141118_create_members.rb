class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.string :name
      t.string :email
      t.boolean :isvalid
      t.boolean :issubscribed
      t.text :msg
      t.integer :member_type

      t.timestamps
    end
  end
end
