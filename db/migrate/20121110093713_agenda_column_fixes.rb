require 'pp'


class AgendaColumnFixes < ActiveRecord::Migration
  


  def change
    remove_column :clubs, :default_agenda_definition_id
    add_column :agenda_definitions, :meeting_type_id, :integer, :default => 0
    puts "fix  --------  stage 1 -----------"

    x = AgendaDefinition.find(9)
    x.name = "Regular Meeting"
    x.save

    puts "fix  --------  stage 2 -----------"




    
    Club.all.each do |club|
      @meeting_type = MeetingType.where("club_id = ? and is_default = true ", club.id).first
      if @meeting_type.nil? == true
        @meeting_type               = MeetingType.new
        @meeting_type.club_id       = club.id
        @meeting_type.description   = "Regular Meeting"
        @meeting_type.is_default    = true
        @meeting_type.hour          = 12
        @meeting_type.minute        = 0
        @meeting_type.am_pm         = 'PM'
        @meeting_type.meeting_time  = "12:00 PM"
      else
        if @meeting_type.hour.nil? == true
          @meeting_type.hour = 12 
          @meeting_type.minute = 0  
          @meeting_type.am_pm = 'PM'
        end  
      end
      @meeting_type.save






      puts "fix  --------  stage 3 -----------"

      @agenda = AgendaDefinition.where("meeting_type_id = 0 and club_id = ? and name like 'Regular%'",  @meeting_type.club_id).first
      if @agenda.nil? == true
        @agenda                                = AgendaDefinition.new
        @agenda.club_id                        = club.id
        @agenda.description                    = "Regular Meeting"
        @agenda.name                           = "Regular Meeting"
        @agenda.show_absent_members            = false
        @agenda.show_next_meeting_open_roles   = false
        @agenda.show_this_meeting_open_roles   = false
      end
      @agenda.meeting_type_id = @meeting_type.id
      pp @agenda
      @agenda.save
      @agenda = nil
      
   

      puts "fix  --------  stage 4 -----------"

      x = AgendaDefinition.find(9)
      x.name = "TM Meeting"
      x.save

      recs = AgendaDefinition.where("meeting_type_id = 0 ",  @meeting_type.club_id)
      recs.each do |rec|
        meeting_type               = MeetingType.new
        meeting_type.club_id       = rec.club_id
        meeting_type.description   = rec.name
        meeting_type.is_default    = false
        meeting_type.hour          = 12
        meeting_type.minute        = 0
        meeting_type.am_pm         = 'PM'
        meeting_type.meeting_time  = "12:00 PM"
        meeting_type.save
        rec.meeting_type_id = meeting_type.id
        rec.save
      end
   


      puts "fix  --------  stage 5 -----------"


      Meeting.all.each do |meeting|
        if Club.where("id = ?", meeting.club_id).length == 0
          meeting.delete
        end
      end


      Meeting.all.each  do  |meeting| 
        puts "got a meeting....."
        $stdout.flush
        
        if meeting.meeting_type_id.nil? == true
          puts "got meeting with null meeting_type_id"
          pp meeting
        else
          puts "got a meeting that already has a meeting_type_id"
          next
        end

        $stdout.flush
        type = MeetingType.where("club_id = ? and is_default = true", meeting.club_id).first
        puts "got the meeting_type to plug it in to meeting"
        $stdout.flush
        meeting.hour          = type.hour
        meeting.minute        = type.minute
        meeting.am_pm         = type.am_pm
        meeting.meeting_type_id = type.id
        meeting.save
      end
      puts "fix  --------  DONE  -----------"
    end
  end
end

