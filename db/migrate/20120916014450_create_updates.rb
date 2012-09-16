class CreateUpdates < ActiveRecord::Migration
  def change
    create_table :updates do |t|
      t.integer :major
      t.integer :minor
      t.integer :patch
      t.text :description

      t.timestamps
    end
  end
end
