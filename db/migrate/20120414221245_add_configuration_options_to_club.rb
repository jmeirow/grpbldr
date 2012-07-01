class AddConfigurationOptionsToClub < ActiveRecord::Migration
  def change
  	change_table :clubs do |t|
  		t.boolean :email_enabled, :default => true	
  	end 

  end
end
