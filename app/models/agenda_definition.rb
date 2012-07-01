class AgendaDefinition < ActiveRecord::Base
  attr_accessible :description, :name, :club_id 



  def self.regular_meeting(club_id)
  	AgendaDefinition.where("club_id = ? and name = ?", club_id, 'Regular Meeting').first
  end



end
