require 'chronic'

class Absence < ActiveRecord::Base
  


  attr_accessible :member_id, :start_date, :end_date,   :start_date_display, :end_date_display


  
  validates :start_date, :end_date, :presence => true

  validate :start_date_display_parseable , :end_date_display_parseable , :end_date_gt_start_date,   :conflicts_with_meeting?

 



 def conflicts_with_meeting?
 	cnt = Meeting.joins(:assignments).where(" assignments.member_id = ? and meetings.meeting_date between ? and ? ", self[:member_id], start_date, end_date) 
 	errors.add(:the_dates_you_entered," conflict with one or more meetings you've already been assigned to.") unless cnt.count == 0
 end

 def future_dates?
 	errors.add(:start_date,": Only enter absences that will occur in the future.") unless start_date >= Date.today
 end

  # def parse_to_date_objects
  #  	start_date = Chronic.parse(start_date)
  # 	end_date = Chronic.parse(end_date)
  # end

  # def start_date_parseable?(dt)
  # 	errors.add(:start_date, "is not an understandable date format.") unless parseable?(dt)
  # end
  # def end_date_parseable?(dt)
  # 	errors.add(:end_date, "is not an understandable date format.") unless parseable?(dt)
  # end

  # def parseable?(dt)
  # 	Chronic.parse(dt).nil? 
  # end

  # def validate_end_date_before_start_date
  #   if end_date && start_date
  #     errors.add(:end_date, "must be greater than or equal to Start Date") if end_date < start_date
  #   end
  # end
  
  # virtual properties
  
  def member_full_name    
    @member = Member.find(self[:member_id])
    return @member.full_name
  end
end
