class AddIncludeAbsencesOnAgendaDefinition < ActiveRecord::Migration
  def change
  	 add_column :agenda_definitions, :show_absent_members, :boolean, :required => :true, :default => false
  end

end
