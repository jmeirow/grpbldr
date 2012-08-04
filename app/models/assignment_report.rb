class AssignmentReport < ActiveRecord::Base
	
	# modules
	include ActiveBuilder

	 
  #callbacks
  after_find :gb_set_attribute_methods_from_attributes

 
  #callbacks
  after_find :gb_set_attribute_methods_from_attributes 
end
