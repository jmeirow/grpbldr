class InitializeCounterCacheToZero < ActiveRecord::Migration
  def up
    change_column :meetings, :assignments_count, :integer, :default => 0, :null => false
  end

  def down
  end
end
