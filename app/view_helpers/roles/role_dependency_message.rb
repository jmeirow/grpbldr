class RoleDependencyMessage

  def initialize (role)  
    @role = role
  end

  def message
    rga_cnt = @role.count_of_role_group_associations
    assignment_cnt = @role.count_of_assignments
    msg1 = "In #{@role.count_of_role_group_associations} RoleGroup(s)" if rga_cnt > 0 
    msg2 =  "Has #{@role.count_of_assignments} Assignment(s)." if  assignment_cnt > 0
    if msg1 && msg2 
      msg = msg1 + '<br/>' + msg2
    end
    if msg1 && !msg2
      msg = msg1
    end
    if msg2 && !msg1
      msg = msg2
    end
    msg
  end       

end