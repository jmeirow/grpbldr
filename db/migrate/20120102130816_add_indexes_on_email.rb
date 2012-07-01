class AddIndexesOnEmail < ActiveRecord::Migration
  def up
    add_index :members, :email
    add_index :users, :email
  end

  def down
  end
end
