class CreateScenarios < ActiveRecord::Migration
  def change
    create_table :scenarios do |t|
      t.string :name
      t.integer :line
      t.string :json_id, :null => false 
      t.text :description
      t.integer :feature_id
      t.timestamps
    end
    
    add_index :scenarios, :name, :name => 'scenarios_name'
  end
end
