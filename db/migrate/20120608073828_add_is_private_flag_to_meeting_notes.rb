class AddIsPrivateFlagToMeetingNotes < ActiveRecord::Migration
  def change
  	change_table :meeting_notes do |t|
  		t.boolean :is_private, :default => false	
  	end
  end
end
