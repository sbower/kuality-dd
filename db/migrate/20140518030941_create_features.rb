class CreateFeatures < ActiveRecord::Migration
  def change
    create_table :features do |t|
      t.string :name
      t.integer :line
      t.string :json_id, :null => false 
      t.text :description
      t.timestamps
    end
    
    add_index :features, :name, :name => 'features_name'
    add_index :features, :json_id, :name => 'features_json_id'
  end
end
