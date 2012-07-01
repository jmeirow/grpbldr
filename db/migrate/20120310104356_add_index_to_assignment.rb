class AddIndexToAssignment < ActiveRecord::Migration
  def change
    change_table :assignments do |t|
      t.index :member_id
    end
    
  end
end
