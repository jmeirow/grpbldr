module ApplicationHelper

  include SystemServices 

  def email_available_for_header?
    email_available?(current_club)
  end

end
