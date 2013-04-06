class ChangeEmailRecipToText < ActiveRecord::Migration
  def up
    change_column :emails, :to, :text

  end
end
