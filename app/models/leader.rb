class Leader < ActiveRecord::Base

	
  # modules
  include ActiveBuilder

  #access
  attr_accessible :club_id, :description, :title

  #callbacks
  after_find :gb_set_attribute_methods_from_attributes
    
end
