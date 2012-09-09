class RoleGroup < ActiveRecord::Base
  


  # modules
  include ActiveBuilder

  #access
  attr_accessible 	:description, 	:club_id , :id

  #callbacks  
  after_find :gb_set_attribute_methods_from_attributes


  has_many :role_group_associations
  has_many :roles, :through => :role_group_associations

end
