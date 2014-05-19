module NameSearchable
  extend ActiveSupport::Concern

  included do
    scope :search, ->(keyword) { where("name LIKE '%#{keyword}%'") }
  end
  
  module ClassMethods
  end
  
end