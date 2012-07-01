class CreateRoleGroups < ActiveRecord::Migration
  def change
    create_table :role_groups do |t|
      t.integer :role_id
      t.string :group_name

      t.timestamps
    end
  end
end
