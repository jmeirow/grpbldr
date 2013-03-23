require 'custom/system_services.rb'

module ApplicationHelper

  include SystemServices 

  def email_available_for_header?
    email_available_for_club? (current_club)
  end

end
