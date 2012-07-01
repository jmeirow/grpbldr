class CreateLeaders < ActiveRecord::Migration
  def change
    create_table :leaders do |t|
      t.integer :club_id
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
