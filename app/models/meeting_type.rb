require './lib/custom/time_parser.rb'
require './lib/custom/date_time_validations.rb'



class MeetingType < ActiveRecord::Base
  
   
  # modules
  include DateTimeValidations
  include ActiveBuilder
 

  attr_accessible :club_id, :description, :is_default, :hour, :minute, :am_pm, :meeting_time

  after_validation :update_time

  validate :meeting_time_parseable
  validates :description, :presence => true




  # def meeting_time
  #  '%02d' %  hour + ':' + '%02d' %  minute + ' ' +  am_pm  
  # end

  # def meeting_time=(value)
  #   @meeting_time = value
  # end

  
end
