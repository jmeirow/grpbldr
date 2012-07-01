class AddStartAndEndTimesAgendaLineItems < ActiveRecord::Migration
  def change
  	add_column :agenda_line_items, :start_time, :string
  	add_column :agenda_line_items, :end_time, :string
  end
end
