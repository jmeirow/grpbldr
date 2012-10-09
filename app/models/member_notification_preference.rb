class MemberNotificationPreference < ActiveRecord::Base
  attr_accessible :enabled, :member_id, :notification_type_id




  def self.all_preferences member_id
    self.add_new member_id
    self.current_preferences member_id
  end



private

  def self.current_preferences member_id
    MemberNotificationPreference.where("member_id = ?", member_id)
  end






  def self.new_preferences member_id
    all_types = NotificationType.all
    all_prefs = self.current_preferences member_id
    

     


    end

    
 

  end




end
