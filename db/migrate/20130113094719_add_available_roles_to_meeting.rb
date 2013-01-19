class AddAvailableRolesToMeeting < ActiveRecord::Migration
  def change

    add_column :meetings, :available_roles, :text

    sql = %q(
          
          update meetings a 
          set available_roles = ''   
    )
    ActiveRecord::Base.connection.execute(sql)  
      

    
  end
end
