class CreateSysConfigurations < ActiveRecord::Migration
  def change
    create_table :sys_configurations do |t|

      t.timestamps
    end
  end
end
