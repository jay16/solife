class CreateLives < ActiveRecord::Migration
  def change
    create_table :lives do |t|
      t.string :title
      t.string :subtitle
      t.string :info 
      t.datetime :lives_at

      t.timestamps
    end
  end
end
