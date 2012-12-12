
class SelectLists

  attr_reader :meeting_type_select_list, :member_select_list,   :role_select_list

  def initialize cache, meeting_type
    @cache = cache 
    @member_select_list = cache.current_members
    @role_select_list = build_role_select_list
    @meeting_type_select_list = @cache.meeting_types

  end
private



 

  def member_of_group? role_id
    @role_group_associations.map {|x| x.role_id }.include? role_id
  end

  def build_role_select_list
    @cache.roles.map {|x| [x.id, x.description]}
      # reject { |x| member_of_group? x.id }.
      # map {|x| [x.id, x.description]}

    
    # role_for_this_meeting_type = @cache.role_meeting_types.select { |x| x.meeting_type_id == @meeting_type_id }.map {|x| x.role_id }
    # role_group_associations = @cache.role_group_associations.select {|assoc| role_for_this_meeting_type.include? assoc.role_id } 
    # applicable_groups = @cache.role_groups.select {|group| role_group_associations.map {|x| x.role_group_id }.include? group.id }
    # # contains roles for selcted meeting_type less roles belonging to a role group
    # a  = @cache.roles.
    #       select { |role| role_for_this_meeting_type.include? role.id }.
    #       reject { |role| role_group_associations.include? role.id }.
    #       map    { |role| [role.id, role.description] } 
    
    # b = @cache.role_groups.
    #       select {|group| role_group_associations.map {|x| x.group_is}.include? group.id }.
    #       map { |group| [group.id * -1, group.description] }
    # a + b


  end
end
