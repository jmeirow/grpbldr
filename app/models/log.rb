class Log < ActiveRecord::Base
  attr_accessible :action, :changed_data, :data_after, :data_before, :model_name, :txn_id, :user_name
end
