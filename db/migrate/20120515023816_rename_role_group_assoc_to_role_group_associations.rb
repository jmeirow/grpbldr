class RenameRoleGroupAssocToRoleGroupAssociations < ActiveRecord::Migration
  def change
  	rename_table :role_group_assoc, :role_group_associations
  end
 
end
