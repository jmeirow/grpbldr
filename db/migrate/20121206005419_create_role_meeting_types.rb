class CreateRoleMeetingTypes < ActiveRecord::Migration
  def change
    create_table :role_meeting_types do |t|
      t.integer :role_id
      t.integer :meeting_type_id

      t.timestamps
    end
  end
end
