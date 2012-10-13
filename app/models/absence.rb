require 'chronic'

class Absence < ActiveRecord::Base
  
  # modules
  include ActiveBuilder

  #access
  attr_accessible :member_id, :start_date, :end_date,   :start_date_display, :end_date_display


  #validations
  validates :start_date, :end_date, :presence => true
  validate :start_date_display_parseable , :end_date_display_parseable , :end_date_gt_start_date,   :conflicts_with_meeting?

 


  #attributes and methods
  def conflicts_with_meeting?
  	cnt = Meeting.joins(:assignments).where(" assignments.member_id = ? and meetings.meeting_date between ? and ? ", self[:member_id], start_date, end_date) 
  	errors.add(:the_dates_you_entered," conflict with one or more meetings you've already been assigned to.") unless cnt.count == 0
  end

  def future_dates?
  	errors.add(:start_date,": Only enter absences that will occur in the future.") unless start_date >= Date.today
  end
  
  def member_full_name    
    @member = Member.find(self[:member_id])
    return @member.full_name
  end

  def self.absent_members(club_id, meeting_date )
    Member.joins('INNER JOIN absences on absences.member_id = members.id').where("club_id = ? and  ? between absences.start_date and absences.end_date and ? between members.start_date and members.end_date",  
        club_id, meeting_date, meeting_date).order("last_name, first_name") 
  end


end
 