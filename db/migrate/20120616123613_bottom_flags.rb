class BottomFlags < ActiveRecord::Migration
  def change
  	add_column :agenda_bottoms, :include_next_meeting, :string
  	add_column :agenda_bottoms, :include_next_meeting_roles, :string
  	add_column :agenda_bottoms, :include_next_meeting_open_roles, :string
  	
  end

 
end
