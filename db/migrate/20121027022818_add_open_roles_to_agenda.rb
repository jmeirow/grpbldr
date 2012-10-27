class AddOpenRolesToAgenda < ActiveRecord::Migration
  def change
  	 add_column :agenda_definitions, :show_next_meeting_open_roles, :boolean, :required => :true, :default => false
  end
end
