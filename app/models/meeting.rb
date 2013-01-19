require './lib/custom/time_parser.rb'
require './lib/custom/date_time_validations.rb'
require './lib/view_models/meetings/meeting_index_cache.rb'

require 'pry'
require 'pry_debug'



class Meeting < ActiveRecord::Base

##############################################################################
#       Modules
##############################################################################

  include ActiveBuilder
  include DateTimeValidations
  
##############################################################################
#        Access 
##############################################################################

  attr_accessible  :meeting_date, :id ,  :hour, :minute, :am_pm, :meeting_type_id, :meeting_time, :meeting_date_display, :available_roles
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

  def self.needing_assignments(club_id, meeting_type_id)
    Meeting.where("club_id = ? and meeting_type_id = ? and assignments_count < ? and meeting_date > ?", club_id, meeting_type_id, Role.roles(club_id, meeting_type_id).count, Date.today).order("meeting_date")
  end


  def self.all_future_for_type(club_id,meeting_type_id)
    Meeting.where("club_id = ?  and meeting_type_id = ? and meeting_date >= ?", club_id, meeting_type_id,  Date.today).order("meeting_date")
  end


##############################################################################
#        INSTANCE METHODS 
##############################################################################

  def meeting_info
    @meeting_info ||= MeetingInfo.new(self)
  end

  def next_meeting
    Meeting.where("club_id = ? and meeting_date > ?", self[:club_id], self[:meeting_date]).order("meeting_date").limit(1).first
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
    @meeting_date_display = val
    @meeting_date = val
    @meeting_date_error_msg = get_error_for_date(val,:meeting_date)
  end


  def add_to_available_roles obj
    if obj.class == Role && obj.club_id == self[:club_id] 
      roles = self[:available_roles].split(',')
      roles << obj.id 
      self[:available_roles] = roles.join(',')
    end
  end

  def remove_from_available_roles obj
    if obj.class == Role && obj.club_id == self[:club_id] 
      roles = self[:available_roles].split(',').collect {|x| x.to_i}
      roles.delete(obj.id)
      self[:available_roles] = roles.join(',')
    end
  end


  def available_roles_as_list
    self[:available_roles]
  end

  def available_role_count
    available_roles_as_array.length
  end

  def self.populate_available_roles
    Meeting.where("meeting_date >= ?", Date.today).order("id").each do |meeting|
      all_roles_for_meeting = get_all_roles_for_meeting meeting 
      filled_roles_for_meeting = get_filled_roles_for_meeting meeting  
      available_meetings = all_roles_for_meeting - filled_roles_for_meeting 
      available_meetings.each do |role_id|
        role = Role.find(role_id)
        meeting.add_to_available_roles role 
        meeting.save
      end
    end
  end

  def available_roles_as_array
    str = '[' + self[:available_roles] + ']'
    eval str
  end

  def self.get_all_roles_for_meeting meeting 
    RoleMeetingType.select { |x| x.meeting_type_id == meeting.meeting_type_id}.map {|x| x.role_id }
  end

  def self.get_filled_roles_for_meeting meeting 
    Assignment.select {|x| x.meeting_id == meeting.id }.map {|x| x.role_id }
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
