class CreateConsumes < ActiveRecord::Migration
  def change
    create_table :consumes do |t|
      t.integer :user_id
      t.float :volue
      t.text :msg

      t.timestamps
    end
  end
end
