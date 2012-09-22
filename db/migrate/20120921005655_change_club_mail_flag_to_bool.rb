class ChangeClubMailFlagToBool < ActiveRecord::Migration
   def change
    change_table :clubs do |t|
      t.remove :mail_enabled 
      t.boolean :mail_enabled, :default => :true
    end
  end
end
