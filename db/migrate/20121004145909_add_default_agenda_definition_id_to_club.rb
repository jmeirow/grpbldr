class AddDefaultAgendaDefinitionIdToClub < ActiveRecord::Migration
  def change
  	add_column :clubs, :default_agenda_definition_id, :integer, :required => :true, :default => 0
  end
end
