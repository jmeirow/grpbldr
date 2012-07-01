class AddColsToAssignmentReports < ActiveRecord::Migration
  def change
    add_column :assignment_reports, :member_id, :integer
    add_column :assignment_reports, :meeting_date, :datetime
    add_column :assignment_reports, :reason, :string
    remove_column :assignment_reports, :message
  end
end
