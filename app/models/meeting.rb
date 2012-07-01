class Meeting < ActiveRecord::Base
  include ActiveModel::MassAssignmentSecurity

  attr_accessible  :meeting_date, :id , :meeting_date_display, :hour, :minute, :am_pm
  attr_accessor :padded_minutes
  
  has_many :assignments
  

  # class methods
  
  def self.get_total_open_roles_for_meetings(meeting_ids, club_id)
    cnt = 0
    meetings = Meeting.where("club_id = ? and id in (?)", club_id, meeting_ids)
    meetings.each do |meeting|
      cnt = cnt + meeting.unfilled_roles_count
    end
    return cnt
  end
  


  def self.CanPerform(member, role)
    cnt = Meeting.where("member_id = ? and role_id = ?", member.id, role.id)
    return cnt > role.meetings_to_skip_before_assigning_again
  end
 


  def self.needing_assignments(club_id)
    Meeting.where("club_id = ? and assignments_count < ? and meeting_date > ?", club_id, Role.roles(club_id).count, Date.today).order("meeting_date")
  end



  def self.all_future(club_id)
    Meeting.where("club_id = ?   and meeting_date >= ?", club_id,   Date.today).order("meeting_date")
  end
 


  # instance code
  
  
	validate :meeting_date_display_parseable 
  validates :hour , :presence => true, :numericality => {:only_integer => true}, inclusion: {in: 1..12}
  validates :minute , :presence => true, :numericality => {:only_integer => true}, inclusion: {in: 0..59}
  
	
	#attr_accessor :meeting_date, :meeting_date_display
	#attr_reader :get_total_open_roles_for_meetings


		
  def unfilled_roles_count (club_id)
    Role.roles(club_id).length -  self[:assignments_count] 
  end

  
  def unfilled_roles(club_id)
    Role.needed_for_meeting(self[:id])
  end
  
  def has_available_roles?
    unfilled_roles > 0
  end

  def padded_minutes
    if self[:minute]  < 10
      '0' + self[:minute].to_s
    else
       self[:minute]
    end
  end
  
  def get_error_for_date (keyed, date_prop_symbol)
    return 'is required' unless !keyed.blank?
    return 'is not a valid date format.' unless !(self[date_prop_symbol] = Chronic.parse(keyed)).nil?
    return ''
  end

  
  def meeting_date_display
   	return meeting_date.strftime("%m/%d/%Y") unless meeting_date.blank?	
  end


  def meeting_date_display=(val)
   	self[:meeting_date_display], self[:meeting_date]  = val
   	@meeting_date_error_msg = get_error_for_date(val,:meeting_date)
  end

  
  def meeting_date_display_parseable
    return !errors.add(:meeting_date, @meeting_date_error_msg) unless @meeting_date_error_msg.blank?
  end

  
end
