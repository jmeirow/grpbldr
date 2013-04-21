class RenameDistListDescription < ActiveRecord::Migration
  def change
    rename_column :dist_lists, :descritpion, :description
  end

 
end
