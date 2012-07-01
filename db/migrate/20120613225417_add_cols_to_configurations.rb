class AddColsToConfigurations < ActiveRecord::Migration
  def change
  	add_column :sys_configurations, :config_key, :string, :uniqueness => true
  	add_column :sys_configurations, :config_value, :string
  end
end
