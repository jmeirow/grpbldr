class CreateGenericLogs < ActiveRecord::Migration
  def change
    create_table :generic_logs do |t|
      t.text :information

      t.timestamps
    end
  end
end
