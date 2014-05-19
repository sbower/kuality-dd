class CreateSteps < ActiveRecord::Migration
  def change
    create_table :steps do |t|
      t.string :name, :null => false
      t.timestamps
    end
    
    add_index :steps, :name, :name => 'steps_name'
  end
end
