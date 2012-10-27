class ShowThisMeetingsOpenRolesOnAgenda < ActiveRecord::Migration
  def change
  	 add_column :agenda_definitions, :show_this_meeting_open_roles, :boolean, :required => :true, :default => false
  end
end
