class CreateTodos < ActiveRecord::Migration
  def change
    create_table :todos do |t|
      t.string :todo
      t.string :todo_type
      t.string :statu
      t.text :desc

      t.timestamps
    end
  end
end
