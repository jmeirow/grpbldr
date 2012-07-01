class CreateMeetingAssignments < ActiveRecord::Migration
  def change
    create_table :meeting_assignments do |t|
      t.integer :member_id
      t.integer :role_id
      t.integer :meeting_id

      t.timestamps
    end
  end
end
