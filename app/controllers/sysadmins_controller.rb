class SysadminsController <  ApplicationController



  def blank

  end

  def all_members

  	@members = Member.order("last_name,first_name")
  end
 
end