class RoleMeetingType < ActiveRecord::Base
  attr_accessible :meeting_type_id, :role_id





  def self.role_ids_for_meeting_type(meeting_type_id)
    result = Array.new
    RoleMeetingType.where("meeting_type_id = ?", meeting_type_id).each { |role_meeting_type| result << role_meeting_type.role_id  }
    result
  end
end
