class CreateUserConsumes < ActiveRecord::Migration
  def change
    create_table :user_consumes do |t|
      t.integer :user_id
      t.integer :consume_id

      t.timestamps
    end
  end
end
