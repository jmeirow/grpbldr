class AddClubIdToMembersMeetingsAndRoles < ActiveRecord::Migration
  def change
    add_column :members, :club_id, :integer
    add_column :meetings, :club, :integer
    add_column :roles, :club_id, :integer
  end
end
