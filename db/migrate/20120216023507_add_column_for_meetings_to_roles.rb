class AddColumnForMeetingsToRoles < ActiveRecord::Migration
  def change
    add_column :roles, :meetings_to_skip_before_assigning_again, :integer
  end
end

