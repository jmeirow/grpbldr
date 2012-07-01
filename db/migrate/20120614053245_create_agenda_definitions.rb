class CreateAgendaDefinitions < ActiveRecord::Migration
  def change
    create_table :agenda_definitions do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
