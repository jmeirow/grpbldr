class AddEmailNameToClub < ActiveRecord::Migration
  def change
  	add_column :clubs, :email_name, :string
  end
end
