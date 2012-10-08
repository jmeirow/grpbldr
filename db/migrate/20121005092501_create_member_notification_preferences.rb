class CreateMemberNotificationPreferences < ActiveRecord::Migration
  def change
    create_table :member_notification_preferences do |t|
      t.integer :member_id
      t.integer :notification_type_id
      t.boolean :enabled

      t.timestamps
    end
  end
end
