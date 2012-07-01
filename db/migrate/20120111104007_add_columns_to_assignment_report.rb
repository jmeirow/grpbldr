class AddColumnsToAssignmentReport < ActiveRecord::Migration
  def change
    
    create_table :assignment_reports do |t|
      t.integer :club_id
      t.string :assignment_reports 
      t.timestamps
    end

  end
end
