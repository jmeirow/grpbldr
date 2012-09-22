class AddClubMailSwitch < ActiveRecord::Migration
  def change
    add_column :clubs, :mail_enabled, :string, :required => :true, :default => 'Y'
  end
end
