class AddHeadingToAgendaBottom < ActiveRecord::Migration
  def change
  	add_column :agenda_bottoms, :heading_text, :text 
  end
end
