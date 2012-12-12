require 'pp'


class AgendaColumnFixes < ActiveRecord::Migration
  

  #  delete the clubs we don't need
  #  temporarily rename the agenda_definition and meeting_type for Northern TM
  #  create the default meeting_type for any club without a meeting_type
  #  for each meeting_type without an agenda_definition, create the agenda_definition



  def change

    remove_column :clubs, :default_agenda_definition_id

    add_column :agenda_definitions, :meeting_type_id, :integer, :default => 0


    sql = %q(

    delete from meeting_types where club_id in (1,9) or id = 5;
    update meeting_types set is_default = true where id = 6;

    delete from agenda_definitions where club_id in (1,9);

    update agenda_definitions set name = 'Regular' where id = 9 or name = 'Regular Meeting';

    update meeting_types set hour=12, minute=0, am_pm = 'PM'  where hour is NULL;


    insert into agenda_definitions (name, description, created_at, updated_at, club_id, 
            show_absent_members, show_next_meeting_open_roles, show_this_meeting_open_roles, meeting_type_id) values (
    'Regular', 'Regular', NOW(), NOW(), 12,false, false, false, 0);

  

    insert into meeting_types (club_id,description, is_default, hour, minute, am_pm,  created_at, updated_at)
    select  club_id, 
        name,
        case when name = 'Regular' then true 
        else false 
        end, 
        12, 0, 'PM'   , now(), now()

    from agenda_definitions
    where name not in (select description from meeting_types);


    update agenda_definitions set name = 'TM Meeting' where club_id = 11;
    update meeting_types set description = 'TM Meeting' where club_id = 1;

    update agenda_definitions a
    set meeting_type_id = b.id
    from meeting_types b
    where a.club_id = b.club_id
    and rtrim(a.name, ' ') = rtrim(b.description, ' ') and (a.meeting_type_id is null or a.meeting_type_id = 0)

    )

    ActiveRecord::Base.connection.execute(sql)    
   

  end
end


