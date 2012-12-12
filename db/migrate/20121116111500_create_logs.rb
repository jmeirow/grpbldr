class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.string :txn_id
      t.integer :action
      t.string :user_name
      t.string :model_name
      t.text :data_before
      t.text :data_after
      t.text :changed_data

      t.timestamps
    end
  end
end
