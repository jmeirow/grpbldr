class CreateAgendaBottoms < ActiveRecord::Migration
  def change
    create_table :agenda_bottoms do |t|
      t.integer :agenda_definition_id
      t.text :body_text

      t.timestamps
    end
  end
end
