class MeetingType < ActiveRecord::Base
  attr_accessible :club_id, :description, :is_default, :hour, :minute, :am_pm
end
