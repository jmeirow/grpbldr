class CreateAgendaTops < ActiveRecord::Migration
  def change
    create_table :agenda_tops do |t|
      t.integer :agenda_definition_id
      t.string :heading_text
      t.text :body_text
      t.string :image_source
      t.integer :image_width
      t.integer :image_height

      t.timestamps
    end
  end
end
