class AddClubIdToRoleGroupAssociation < ActiveRecord::Migration
 
  def change
    add_column :role_group_associations, :club_id, :integer
   end
end
