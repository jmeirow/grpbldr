class RemoveRoleIdFromRoleGroupAndAddRoleGroupAssoc < ActiveRecord::Migration
  def change

	remove_column :role_groups, :role_id

	create_table :role_group_assoc do |t|
      t.integer :role_id
      t.integer :role_group_id
      t.timestamps
    end 

  end

  
end
