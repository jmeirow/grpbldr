class AddContactInfoToMember < ActiveRecord::Migration
  def change
  	change_table :members do |t|
  		t.string :address_one
  		t.string :address_two
  		t.string :city
  		t.string :state
  		t.string :zip_code
  		t.string :phone
  		t.string :mobile_phone
  	end
  	

  end
end
