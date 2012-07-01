class RenameReportAssignmentColumns < ActiveRecord::Migration
  def up
    rename_column :assignment_reports, :assignment_reports, :message
  end

  def down
  end
end
