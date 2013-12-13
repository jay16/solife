class CreateTraffics < ActiveRecord::Migration
  def change
    create_table :traffics do |t|
      t.integer :userid
      t.string :url
      t.string :controller
      t.string :action
      t.text :browser
      t.string :ip
      t.integer :track_type

      t.timestamps
    end
  end
end
