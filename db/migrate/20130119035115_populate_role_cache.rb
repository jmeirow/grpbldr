class PopulateRoleCache < ActiveRecord::Migration
  def up
    Meeting.populate_available_roles 
  end

   
end
