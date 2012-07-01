class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.string :ip_addr
      t.string :page_uri

      t.timestamps
    end
  end
end
