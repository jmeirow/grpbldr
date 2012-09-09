class RoleGroupAssociation < ActiveRecord::Base
  
  # modules
  include ActiveBuilder



  #access
  attr_accessible 	:role_id, :role_group_id, :club_id

  belongs_to :role
  belongs_to :role_group

  #callbacks  
  after_find :gb_set_attribute_methods_from_attributes

  def self.selected_roles(role_group_id)
     
    
  end

  def self.available_roles(role_group_id )
    
  end


end
