class SetCountToZeroOnRoles < ActiveRecord::Migration
  def up
    
    execute <<-SQL
          UPDATE roles 
            set meetings_to_skip_before_assigning_again = 0
            where meetings_to_skip_before_assigning_again is null
        SQL
  end

  def down
  end
end
