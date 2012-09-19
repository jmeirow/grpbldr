class AddDefaultValueToAgendaLineItemDurationInMinutes < ActiveRecord::Migration
  def change
      change_column :agenda_line_items, :duration_in_minutes, :integer, :default => 0
  end

 
end
