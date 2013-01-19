require './app/event_handlers/EventHandler.rb'

class AssignmentDeletedUpdateMeetingAddToAvailableRolesEH < EventHandler

	# def initialize
	# 	@required_params = [:id]
	# end

	# def execute_business_logic params
	# 	assignment = Assignment.find(params[:id])
	# 	add_back_roles assignment 
	# end

	# def add_back_roles assignment 
	# 	meeting = Meeting.find(assignment.meeting_id)
	# 	meeting.add_available_role Role.find(assignment.role_id)
	# 	meeting.save
	# end

end