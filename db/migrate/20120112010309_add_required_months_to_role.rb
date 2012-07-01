class AddRequiredMonthsToRole < ActiveRecord::Migration
  def change
    add_column :roles, :minimum_required_experience, :integer, :default => 0
  end
end
