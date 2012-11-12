require './lib/custom/time_parser.rb'
require './lib/custom/date_time_validations.rb'



class Meeting < ActiveRecord::Base

##############################################################################
#       Modules
##############################################################################

  include ActiveBuilder
  include DateTimeValidations
  
##############################################################################
#        Access 
##############################################################################

  attr_accessible  :meeting_date, :id ,  :hour, :minute, :am_pm, :meeting_type_id, :meeting_time, :meeting_date_display
  attr_accessor :padded_minutes

  attr_writer :meeting_date_display


##############################################################################
#        Callbacks 
##############################################################################

  after_find :gb_set_attribute_methods_from_attributes
  after_validation :update_time
  

##############################################################################
#        Associations 
##############################################################################

  has_many :assignments
  

##############################################################################
#        Validation 
##############################################################################

  validate :meeting_date_display_parseable 
  validate :meeting_time_parseable
 

##############################################################################
#        Class methods 
##############################################################################

 
  def self.get_total_open_roles_for_meetings(meeting_ids, club_id)
    cnt = 0
    meetings = Meeting.where("club_id = ? and id in (?)", club_id, meeting_ids)
    meetings.each do |meeting|  
      cnt = cnt + meeting.unfilled_roles_count
    end
    return cnt
  end
  

  def self.needing_assignments(club_id)
    Meeting.where("club_id = ? and assignments_count < ? and meeting_date > ?", club_id, Role.roles(club_id).count, Date.today).order("meeting_date")
  end


  def self.all_future(club_id)
    Meeting.where("club_id = ?   and meeting_date >= ?", club_id,   Date.today).order("meeting_date")
  end
 


##############################################################################
#        INSTANCE METHODS 
##############################################################################
  def meeting_time
    '%02d' %  hour + ':' + '%02d' %  minute + ' ' +  am_pm  
  end


  def meeting_time=(value)
    @meeting_time = value
  end


  def next_meeting
    Meeting.where("club_id = ? and meeting_date > ?", self[:club_id], self[:meeting_date]).order("meeting_date").limit(1).first
  end

 
    
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
  

  
  def meeting_date_display
    return meeting_date.strftime("%m/%d/%Y") unless meeting_date.blank? 
  end


  def meeting_date_display=(val)
    #self[:meeting_date_display], self[:meeting_date]  = val
    @meeting_date_display = val
    @meeting_date = val

    @meeting_date_error_msg = get_error_for_date(val,:meeting_date)
  end




  




private


##############################################################################
#        Validation handlers
##############################################################################




  def meeting_date_display_parseable
    return !errors.add(:meeting_date, @meeting_date_error_msg) unless @meeting_date_error_msg.blank?
  end


##############################################################################
#        Callback handlers
##############################################################################





##############################################################################
#        Other Stuff
##############################################################################


  def get_error_for_date (keyed, date_prop_symbol)
    return 'is required' unless !keyed.blank?
    return 'is not a valid date format.' unless !(self[date_prop_symbol] = Chronic.parse(keyed)).nil?
    return ''
  end




  
end
