class Feature < ActiveRecord::Base
  include NameSearchable
  
  has_many :scenarios
  
end
