class RoleGroup < ActiveRecord::Base
  


  # modules
  include ActiveBuilder

  #access
  attr_accessible 	:description, 	:club_id 

  #callbacks  
  after_find :gb_set_attribute_methods_from_attributes


end
