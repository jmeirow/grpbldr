class AddStartTimeToMeeting < ActiveRecord::Migration
  def change
  	add_column :meetings, :hour, :integer
  	add_column :meetings, :minute, :integer
  	add_column :meetings, :am_pm, :string
  end
end
