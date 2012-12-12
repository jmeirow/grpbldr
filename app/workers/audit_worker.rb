class AuditWorker

  include Sidekiq::Worker

  def perform(id,action,member_name,model_name,data_before,data_after,changed_data)
    Log.create( :txn_id => id, :action => action, :user_name =>  member_name,:model_name => model_name, :data_before => data_before, :data_after => data_after, :changed_data => changed_data) 
  end


end
