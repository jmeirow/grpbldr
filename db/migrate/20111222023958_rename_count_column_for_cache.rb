class RenameCountColumnForCache < ActiveRecord::Migration
  def up
      rename_column :meetings, :meeting_assignments_count, :assignments_count
  end

  def down
  end
end
