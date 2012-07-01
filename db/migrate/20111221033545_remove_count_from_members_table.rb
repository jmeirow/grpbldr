class RemoveCountFromMembersTable < ActiveRecord::Migration
  def up
      remove_column :members, :open_assignment_count
      add_column :meetings, :meeting_assignments_count, :integer
  end

  def down
    remove_column :meetings, :meeting_assignments_count
    add_column :members, :open_assignment_count, :integer
  end
end
