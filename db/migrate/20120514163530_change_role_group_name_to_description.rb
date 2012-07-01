class ChangeRoleGroupNameToDescription < ActiveRecord::Migration
  def change

    rename_column :role_groups, :group_name, :description

  end


end
