class ScenarioTag < ActiveRecord::Base
  
  belongs_to :scenario
  belongs_to :tag
  
end
