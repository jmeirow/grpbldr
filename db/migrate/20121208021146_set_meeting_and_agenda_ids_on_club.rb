class SetMeetingAndAgendaIdsOnClub < ActiveRecord::Migration
  def change
     
     sql = %q(


      
          update clubs a
          set default_agenda_definition_id = b.id
          from agenda_definitions b
          where a.id = b.club_id;



          update clubs a
          set default_meeting_type_id = b.id
          from meeting_types b
          where a.id = b.club_id;



          insert into role_meeting_types (role_id, meeting_type_id, created_at, updated_at)
          select a.id, b.default_meeting_type_id, current_timestamp, current_timestamp
          from roles a
          inner join clubs b  on a.club_id = b.id;
        

          update meetings a 
          set meeting_type_id = b.default_meeting_type_id
          from clubs b 
          where a.club_id = b.id




          )


        

      

          ActiveRecord::Base.connection.execute(sql)   

  end

  
end
