class MeetingsToSkipBeforeAssigningAgainDefaultToZero < ActiveRecord::Migration
  def up
      change_column :roles, :meetings_to_skip_before_assigning_again, :integer, :default => 0
  end

  def down
      change_column :roles, :meetings_to_skip_before_assigning_again, :integer, :default => 0
  end
 
 
end
