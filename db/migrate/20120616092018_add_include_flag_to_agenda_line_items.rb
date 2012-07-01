class AddIncludeFlagToAgendaLineItems < ActiveRecord::Migration
  def change
  	add_column :agenda_line_items, :include_in_agenda, :string 
  end
end










