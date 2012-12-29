class AddMeetingDateToMeetingIndex < ActiveRecord::Migration
  def change
    remove_index "meetings", :name => "index_meetings_on_club_id"
    add_index "meetings", ["meeting_date", "club_id"], :name => "meetings_meeting_date_club_id_idx"
  end
end
