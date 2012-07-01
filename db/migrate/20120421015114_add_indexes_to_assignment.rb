class AddIndexesToAssignment < ActiveRecord::Migration
  def change

 

    change_table :assignments do |t|
      t.index :meeting_id
    end


    change_table :assignments do |t|
      t.index :role_id
    end

  end
end
