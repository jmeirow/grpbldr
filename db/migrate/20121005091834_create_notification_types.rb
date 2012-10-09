class CreateNotificationTypes < ActiveRecord::Migration
  def change
    create_table :notification_types do |t|
      t.string :mailer_type
      t.text :description

      t.timestamps
    end
  end
end
