class CreateScenarioTags < ActiveRecord::Migration
  def change
    create_table :scenario_tags, :id => false  do |t|
      t.integer :scenario_id
      t.integer :tag_id
      t.timestamps
    end
    
    add_index :scenario_tags, :scenario_id, :name => 'scenario_tags_scenario_id'
    add_index :scenario_tags, :tag_id, :name => 'scenario_tags_tag_id'
  end
end
