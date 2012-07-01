class CreateAgendaLineItems < ActiveRecord::Migration
  def change
    create_table :agenda_line_items do |t|
      t.integer :agenda_definition_id
      t.integer :sequence_nbr
      t.string :time_format
      t.text :line_item_text
      t.string :person_display_name
      t.string :person_display_name_source

      t.timestamps
    end
  end
end
