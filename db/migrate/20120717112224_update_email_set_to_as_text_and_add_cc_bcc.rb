class UpdateEmailSetToAsTextAndAddCcBcc < ActiveRecord::Migration
  def change
  	add_column :emails, :cc, :text
  	add_column :emails, :bcc, :text
  	change_column :emails, :to, :text
  end
end
