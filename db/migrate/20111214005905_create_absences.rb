class CreateAbsences < ActiveRecord::Migration
  def change
    create_table :absences do |t|
      t.integer :member_id
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
