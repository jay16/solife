class CreateMxes < ActiveRecord::Migration
  def change
    create_table :mxes do |t|
      t.string :domain
      t.string :exchange
      t.integer :preference

      t.timestamps
    end
  end
end
