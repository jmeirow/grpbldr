class ChangeEmailNameToDomain < ActiveRecord::Migration
   def change
    change_table :clubs do |t|
      t.rename :email_name, :domain
    end
  end
end
