class CreateMailers < ActiveRecord::Migration
  def change
    create_table :mailers do |t|
      t.string :name

      t.timestamps
    end
  end
end
