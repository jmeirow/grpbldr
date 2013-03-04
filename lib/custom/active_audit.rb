require 'pry'
require 'pry_debug'
 
module ActiveAudit

  def after_create(observed)
      @data_after= observed.get_state
      @action = 1
      preserve_data_from_this_thread(observed)
      @changes = ''
      AuditWorker.perform_async(@id,@action,@member_name,@model_name,'',@data_after,@changes)
  end


  def before_destroy(observed)
    preserve_data_from_this_thread(observed)
    @data_before = observed.class.find(observed.id).get_state
    @action = 3
    @data_after = ''
    @changes =''
    AuditWorker.perform_async(@id,@action,@member_name,@model_name,@data_before,@data_after,@changes)
  end


  def before_update(observed)
    @data_before = observed.class.find(observed.id).get_state
  end

  def after_update(observed)
    @data_after = observed.get_state
    @action = 2
    preserve_data_from_this_thread(observed)
    @changes = observed.changes
    AuditWorker.perform_async(@id,@action,@member_name,@model_name,@data_before,@data_after,@changes)
  end

private

  def preserve_data_from_this_thread(observed)
    
    @id = "1"
    if LoggedInMember.current.nil? == false 
      @member_name = LoggedInMember.current.full_name
    else
     @member_name = ''
    end
    @model_name = observed.class.name
  end
end