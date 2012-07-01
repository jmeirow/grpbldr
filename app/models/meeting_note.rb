class MeetingNote < ActiveRecord::Base
  attr_accessible :body, :meeting_id, :member_id, :member_name, :is_private
  
end
