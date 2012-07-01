class AddUnfilledAssignmentCount < ActiveRecord::Migration
  def up
    add_column :members, :open_assignment_count, :integer
  end

  def down
    remove_column :members, :open_assignment_count
  end
end
