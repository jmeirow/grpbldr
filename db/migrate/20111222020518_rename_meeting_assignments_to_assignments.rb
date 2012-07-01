class RenameMeetingAssignmentsToAssignments < ActiveRecord::Migration
  def up
      rename_table :meeting_assignments, :assignments
  end

  def down
  end
end
