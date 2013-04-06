class CreateDistLists < ActiveRecord::Migration
  def change
    create_table :dist_lists do |t|
      t.integer :club_id
      t.string :name
      t.text :descritpion
      t.string :active

      t.timestamps
    end
  end
end
