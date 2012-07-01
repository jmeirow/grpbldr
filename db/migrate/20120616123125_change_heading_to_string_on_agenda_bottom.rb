class ChangeHeadingToStringOnAgendaBottom < ActiveRecord::Migration
  def change
	change_column :agenda_bottoms, :heading_text, :string 

  end
end
