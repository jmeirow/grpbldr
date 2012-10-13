class MemberNotificationPreference < ActiveRecord::Base
  attr_accessible :enabled, :member_id, :notification_type_id ,  :description

  attr_accessor :description


  def self.get_all_for_member member_id
    Array.new
  end


  def self.create_missing_instances member_id
      
    
    current_ids = MemberNotificationPreference.where("member_id = ?", member_id).select { |x| x.notification_type_id}
    
     

      



  end



end
