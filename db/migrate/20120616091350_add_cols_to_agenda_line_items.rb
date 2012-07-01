class AddColsToAgendaLineItems < ActiveRecord::Migration
  def change
  	add_column :agenda_line_items, :duration_in_minutes, :integer
  	add_column :agenda_line_items, :line_item_header, :string 
  end
end
