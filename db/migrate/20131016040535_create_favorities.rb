class CreateFavorities < ActiveRecord::Migration
  def change
    create_table :favorities do |t|
      t.string :label
      t.text :desc
      t.boolean :klass

      t.timestamps
    end
  end
end
