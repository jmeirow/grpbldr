class AddCommentToConfig < ActiveRecord::Migration
  def change
  	add_column :sys_configurations, :config_description, :text 
  	 
  end
end
