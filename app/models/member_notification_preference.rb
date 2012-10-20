




class MemberNotificationPreference < ActiveRecord::Base


  attr_accessible :enabled, :member_id, :notification_type_id ,  :description
  attr_accessor :description
  after_initialize :init_description
  #validate :fail_on_even



  # def fail_on_even
  #   errors.add(:enabled,"not saved")
  # end

  def init_description
    if notification_type_id
      type = NotificationType.find(notification_type_id)
      @description = type.description
    end
  end


  def self.get_all_for_member member_id
  
    current_prefs = MemberNotificationPreference.where("member_id = ?", member_id).map { |x| x.notification_type_id}

    NotificationType.all.each do |type|  
      next if (current_prefs & [type.id]).length == 1 
      MemberNotificationPreference.create(  
        :member_id => member_id, 
        :notification_type_id => type.id,
        :description => type.description,
        :enabled => false)
    end
    MemberNotificationPreference.where("member_id = ?", member_id).order("id")
  end
end
