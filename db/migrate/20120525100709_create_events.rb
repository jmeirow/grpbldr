class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :club
      t.string :transacted_by
      t.string :action
      t.string :model
      t.text :detail

      t.timestamps
    end
  end
end
