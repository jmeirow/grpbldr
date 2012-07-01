class AddIndexes < ActiveRecord::Migration
  def up
    add_index :meetings, :club_id
    add_index :roles, :club_id
    add_index :members, :club_id
  end

  def down
  end
end
