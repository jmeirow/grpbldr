

 

  class EventCatalog
    def self.assignment_deleted
      1
    end


    def self.assignment_created
      2
    end

    # etc....

  end



  
  #code publishes an event like this...
  EventQueue.publish(EventCatalog.member_added_assignment, { id: assignment.id })





  # the actual work of the 'publish' happen here
    class EventQueue
      def self.publish (event_id, params)
        EventHandlers.where(event_id: event_id).each do |handler|
          begin         
            ActiveRecord::Base.transaction do 
              log_id = EventLog.log(handler.class.name, params)
              handler.execute(params)
              EventLog.success(log_id)
              ActiveRecord::Transaction.commit
            end
          rescue Exception => e 
            ActiveRecord::Rollback
            EventLog.failed(log_id, e)
            raise e
          end 
        end
      end
    end


  class EventHandler::MemberAddedAssignment

    def execute(params)
      assignment = Assignment.find(params[:id])
      assignment_objects = AssignmentObjects.new(assignment.id)
      return_role_to_array assignment_objects 
    end

    private

    def return_role_to_array (assignment_objects)
      assignment_objects.meeting.add_to_available_roles assignment_objects.role
      assignment_objects.meeting.save
    end
  end


  class AssignmentObjects
    attr_reader :role, :meeting, :member

    def initialize assignment_id, objects
      assignment = Assignment.find(params[:id])
      @meeting = Meeting.find(assignment.meeting_id) if objects.include? :meeting
      @role = Role.find(assignment.role_id) if objects.include? :role
    end
  end



