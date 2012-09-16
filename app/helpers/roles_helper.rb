require "#{ENV['GB_RAILS_ROOT']}/app/view_helpers/roles/role_dependency_message.rb"

module RolesHelper


  def  dependency_message 
    helper  = RoleDependencyMessage.new(@role)
    helper.message
  end



end
