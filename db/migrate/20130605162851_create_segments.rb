class CreateSegments < ActiveRecord::Migration
  def change
    create_table :segments do |t|
      t.integer :klass
      t.string :title
      t.string :permlink
      t.text :content
      t.text :markdown

      t.timestamps
    end
  end
end
