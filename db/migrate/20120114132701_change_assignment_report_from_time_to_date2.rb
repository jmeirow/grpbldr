class ChangeAssignmentReportFromTimeToDate2 < ActiveRecord::Migration
  def up
    remove_column :assignment_reports, :date 
    add_column    :assignment_reports, :meeting_date, :date 
  end

  def down
  end
end
