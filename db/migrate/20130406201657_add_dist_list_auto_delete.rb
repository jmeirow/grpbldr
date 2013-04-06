class AddDistListAutoDelete < ActiveRecord::Migration
  def change
    add_column :dist_lists, :auto_delete, :string, :default => "Y"
  end


end
