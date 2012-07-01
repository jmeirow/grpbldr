class ChangeAssignmentReportFromTimeToDate < ActiveRecord::Migration
  def up
    rename_column :assignment_reports, :meeting_date, :date
  end

  def down
  end
end
