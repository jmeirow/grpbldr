class AddClubIdToAgendaDefinition < ActiveRecord::Migration
  def change
  	add_column :agenda_definitions, :club_id, :integer 
  end
end
