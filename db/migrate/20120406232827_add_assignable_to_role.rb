class AddAssignableToRole < ActiveRecord::Migration
  def change
  
  	change_table :roles do |t|
  		t.boolean :assignable, :default => true	
  	end

  	change_table :members do |t| 
  		t.boolean :assignable, :default => true
  	end

  end

end
