class RoleGroupAssociation < ActiveRecord::Base
  
  # modules
  include ActiveBuilder

  #access
  attr_accessible 	:role_id, :role_group_id, :club_id

  #callbacks  
  after_find :gb_set_attribute_methods_from_attributes


end
