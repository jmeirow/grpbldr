class CreateLeaderHistories < ActiveRecord::Migration
  def change
    create_table :leader_histories do |t|
      t.integer :leader_id
      t.integer :member_id
      t.date :start_date
      t.date :end_date
      t.text :notes

      t.timestamps
    end
  end
end
