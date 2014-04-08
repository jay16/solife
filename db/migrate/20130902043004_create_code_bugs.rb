class CreateCodeBugs < ActiveRecord::Migration
  def change
    create_table :code_bugs do |t|
      t.string :class
      t.string :controler
      t.string :action
      t.string :message
      t.string :file_name
      t.integer :line_number
      t.text :source_extract
      t.string :url

      t.timestamps
    end
  end
end
