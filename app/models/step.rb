class Step < ActiveRecord::Base
  include NameSearchable
  
  has_many :scenarios_steps
  #has_many :scenarios, through: :scenarios_steps
  
end
