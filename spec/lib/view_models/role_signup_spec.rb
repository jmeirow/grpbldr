



class MeetingTypeSelect

  intialize








class RoleSignupCache

  attr_reader :current_members, :meetings, :roles, :role_groups, :role_group_associations, :meeting_types, :assignments, :role_meeting_types
  def initialize club
    #@current_members = Member.current(club)
    #@meetings = Meeting.where("club_id = ? and meeting_date >= ? and unfilled_roles > 0", club.id, Date.today)
    @assignments = Assignments.where("club_id = ? and meeting_id in (?)",club.id, @meeting.map {|x| x.id}  )
    @roles = Roles.roles(club)
    @role_groups = RoleGroup.where("club_id = ?", club.id)
    @role_group_associations = RoleGroupAssociation.where("club_id = ?", club.id)
    @meeting_types = MeetingType.where("club_id = ?", club.id)
    @role_meeting_types = RoleMeeingType.where("club_id = ?", club.id)
  end
end








describe RoleSignup, " RoleSignup is a view_model object that orchestates the retrieval 
                      and building of resources required by the view. 
                      
                      It exists so the only logic required by views is logic on how to display a visual element. 
                      Additonally, it allows for this logic to be tested without resorting to end-to-end tests. " do 





  it " should be a real class "  do   
    rs = RoleSignup.new(nil)
    rs.class.should eq(RoleSignup)
  end 

  it " should accept params on the constructor   " do 
    lambda {role_signup = RoleSignup.new(params)}.should raise_error
  end


  it "should provide a method called view_model " do 
    rs = RoleSignup.new(Hash.new)
    view_model = rs.view_model
  end


  it "view_model should retun an object that represents the view model.  " do
    rs = RoleSignup.new(Hash.new)
    view_model = rs.view_model
    view_model.should_not be_nil
  end

  it "view_model should retun an object that represents the view model.  " do
    rs = RoleSignup.new(Hash.new)
    view_model = rs.view_model
    view_model.should_not be_nil
  end













end

