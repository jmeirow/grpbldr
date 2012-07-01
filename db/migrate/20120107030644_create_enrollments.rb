class CreateEnrollments < ActiveRecord::Migration
  def change
    create_table :enrollments do |t|
      t.string :first_name
      t.string :last_name
      t.string :club_name
      t.string :email
      t.string :password
      t.date   :start_date
      t.timestamps
    end
  end
end
