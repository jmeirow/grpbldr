class AddDefaultTimeToMeetingType < ActiveRecord::Migration
  def change
    add_column :meeting_types, :hour, :integer
    add_column :meeting_types, :minute, :integer
    add_column :meeting_types, :am_pm, :string
    


    cached_ids = Hash.new
    Club.all.each do |club|
      meeting_type = MeetingType.where("club_id = ?", club.id).first
      if meeting_type.nil? == true
        meeting_type = MeetingType.create(:club_id => club.id, :is_default => true, :description => 'Regular')
        cached_ids[club.id] = meeting_type.id
      else
        cached_ids[club.id] = meeting_type.id
      end
    end

    add_column :meetings, :meeting_type_id, :integer

    Meeting.all.each do |mtg|
      mtg.meeting_type_id = cached_ids[mtg.club_id]
      mtg.save
    end


  end
end
