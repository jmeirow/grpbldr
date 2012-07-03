


class TestController < ApplicationController
  
  def email
 


  

    redirect_to club_member_assignments_path(current_club,current_member), :notice => "Sent"
  end
end
