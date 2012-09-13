class CreateMeetingTypes < ActiveRecord::Migration
  def change
    create_table :meeting_types do |t|
      t.integer :club_id
      t.string :description
      t.boolean :is_default

      t.timestamps
    end
  end
end
