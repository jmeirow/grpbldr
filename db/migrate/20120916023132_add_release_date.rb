class AddReleaseDate < ActiveRecord::Migration
  def change
    add_column :updates, :release_date, :date, :required => :true
  end

 
end
