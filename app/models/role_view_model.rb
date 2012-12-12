require 'active_model'

class RoleViewModel 

  include ActiveModel::Validations
  include ActiveModel::Dirty

  attr_accessor :meeting_types
  attr_accessor :role 


  def initialize club, role
    @club = club
    @role = role
    @meeting_types = MeetingTypes.where("club_id = ?", club.id)
  end



  def update_attributes params


  end



end