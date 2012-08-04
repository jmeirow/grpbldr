class MeetingNote < ActiveRecord::Base
	
  # modules
  include ActiveBuilder

  #access
  attr_accessible :body, :meeting_id, :member_id, :member_name, :is_private
  

  #callbacks  
  after_find :gb_set_attribute_methods_from_attributes



end
