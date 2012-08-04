class AgendaDefinition < ActiveRecord::Base
  
  # modules
  include ActiveBuilder

  #access
  attr_accessible :description, :name, :club_id 

  
  #callbacks
  after_find :gb_set_attribute_methods_from_attributes


  def self.regular_meeting(club_id)
  	AgendaDefinition.where("club_id = ? and name = ?", club_id, 'Regular Meeting').first
  end



end
