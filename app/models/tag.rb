class Tag < ActiveRecord::Base
  include NameSearchable
  
  has_many :scenarios, through: :scenario_tags
  has_many :scenario_tags
  
end
