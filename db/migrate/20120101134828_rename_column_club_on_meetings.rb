class RenameColumnClubOnMeetings < ActiveRecord::Migration
  def up
    rename_column :meetings, :club, :club_id
  end

  def down
  end
end
