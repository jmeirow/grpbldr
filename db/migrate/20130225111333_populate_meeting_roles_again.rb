class PopulateMeetingRolesAgain < ActiveRecord::Migration
  def change
    Meeting.populate_available_roles 
  end
end
