class LeaderHistory < ActiveRecord::Base
	
  # modules
  include ActiveBuilder

  #access
  attr_accessible :end_date, :leader_id, :member_id, :notes, :start_date



  #callbacks  
  after_find :gb_set_attribute_methods_from_attributes


  
end
