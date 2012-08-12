class CreateContestSignups < ActiveRecord::Migration
  def change
    create_table :contest_signups do |t|
      t.integer :club_id
      t.string :role_description
      t.integer :member_id

      t.timestamps
    end
  end
end
