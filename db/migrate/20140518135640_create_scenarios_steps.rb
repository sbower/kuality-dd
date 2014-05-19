class CreateScenariosSteps < ActiveRecord::Migration
  def change
    create_table :scenarios_steps do |t|
      t.integer :scenario_id
      t.integer :step_id
      t.string :keyword
      t.integer :line
      t.timestamps
    end
    
    add_index :scenarios_steps, :scenario_id, :name => 'scenarios_steps_scenario_id'
    add_index :scenarios_steps, :step_id, :name => 'scenarios_steps_step_id'
  end
end
