class AddRoleToAssignmentReport < ActiveRecord::Migration
  def change
    add_column :assignment_reports, :role_id, :integer
  end
end
