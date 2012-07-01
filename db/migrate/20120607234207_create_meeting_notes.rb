class CreateMeetingNotes < ActiveRecord::Migration
  def change
    create_table :meeting_notes do |t|
      t.integer :meeting_id
      t.integer :member_id
      t.string :member_name
      t.text :body

      t.timestamps
    end
  end
end
