class CreateDistListMembers < ActiveRecord::Migration
  def change
    create_table :dist_list_members do |t|
      t.integer :dist_list_id
      t.integer :member_id

      t.timestamps
    end
  end
end
