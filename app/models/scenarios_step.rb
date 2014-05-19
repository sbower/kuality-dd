class ScenariosStep < ActiveRecord::Base
  default_scope { order('line ASC') }

  belongs_to :scenario
  belongs_to :step
  
end
