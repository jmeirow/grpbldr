class UpdateRoleCnt2 < ActiveRecord::Migration
  def up
    
    execute <<-SQL
          UPDATE roles 
            set meetings_to_skip_before_assigning_again = 3
        SQL
  end

  def down
  end
end
