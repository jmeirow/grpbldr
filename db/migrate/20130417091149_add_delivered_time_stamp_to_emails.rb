class AddDeliveredTimeStampToEmails < ActiveRecord::Migration
  def change
    add_column :emails, :delivered_ts, :datetime
  end
end
