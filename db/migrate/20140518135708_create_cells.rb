class CreateCells < ActiveRecord::Migration
  def change
    create_table :cells do |t|
      t.integer :row_id
      t.integer :line
      t.string :data
      t.timestamps
    end
  end
end
