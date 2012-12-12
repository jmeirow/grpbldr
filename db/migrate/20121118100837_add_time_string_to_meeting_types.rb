class AddTimeStringToMeetingTypes < ActiveRecord::Migration
  
  def change

    add_column :meeting_types, :meeting_time, :string, :required => false
    add_column :meetings, :meeting_time, :string, :required => false
    update_time

  end


  def update_time

    sql = %q(

        update meeting_types set meeting_time = 
          replace(
          concat_ws(  ':',
          hour,
          to_char(minute, '00'))
          , ' ', '') || ' ' || am_pm   ;
 
 
        delete from meetings where club_id not in (select id from clubs);

        update meetings set meeting_time = 
          replace(
          concat_ws(  ':',
          hour,
          to_char(minute, '00'))
          , ' ', '') || ' ' || am_pm   ;

 

 


        update meetings
          set meeting_type_id = meeting_types.id  
          from meeting_types 
          where meetings.club_id = meeting_types.club_id   ;
  
      )
  

      ActiveRecord::Base.connection.execute(sql)   

  end




   





end

