class FixClubAgendaAndMeetingCols < ActiveRecord::Migration
  def change
    rename_column :clubs, :default_agenda_definiton_id, :default_agenda_definition_id
    add_column :clubs, :default_meeting_type_id, :integer, :default => 0

  end

 
end
