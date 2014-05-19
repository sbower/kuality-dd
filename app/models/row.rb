class Row < ActiveRecord::Base
  
  belongs_to :scenarios_step
  has_many :cells
  
end
