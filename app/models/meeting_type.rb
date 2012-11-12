require './lib/custom/time_parser.rb'
require './lib/custom/date_time_validations.rb'



class MeetingType < ActiveRecord::Base
  
   
  include DateTimeValidations

 

  attr_accessible :club_id, :description, :is_default, :hour, :minute, :am_pm, :meeting_time
  

 

  after_validation :update_time

  
 

  validate :meeting_time_parseable

  def meeting_time
    '%02d' %  hour + ':' + '%02d' %  minute + ' ' +  am_pm  
  end

  def meeting_time=(value)
    @meeting_time = value
  end

  
end
