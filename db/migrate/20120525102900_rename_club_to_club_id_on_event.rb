class RenameClubToClubIdOnEvent < ActiveRecord::Migration
  def change

    rename_column :events, :club, :club_id

  end

end
