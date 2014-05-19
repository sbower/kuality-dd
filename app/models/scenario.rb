class Scenario < ActiveRecord::Base
  include NameSearchable
  
  belongs_to :feature
  has_many :steps, through: :scenarios_steps
  has_many :tags, through: :scenario_tags
  has_many :scenarios_steps
  has_many :scenario_tags
  
  validates_presence_of :feature
end
