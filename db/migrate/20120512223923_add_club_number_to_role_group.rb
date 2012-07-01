class AddClubNumberToRoleGroup < ActiveRecord::Migration
  def change
    add_column :role_groups, :club_id, :integer
  end
end
