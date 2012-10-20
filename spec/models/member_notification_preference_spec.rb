require 'spec_helper'


$nbr = 0
def nbr
  $nbr = $nbr + 1
end

def cleanup
  MemberNotificationPreference.destroy_all
end


describe MemberNotificationPreference do

  context "\nEnd-user requirements:" do

    context "\nWhen:" do 

      context "\nViewing a Member Notification Preference on the members preferences page" do
  
        # 
      
        it "\n #{nbr}: should have a user-friendly description of the notification type." do
          mnp = MemberNotificationPreference.new
          mnp.description = "some text"
          mnp.description.should eq("some text")
        end

        it "\n #{nbr}: should have an 'enabled' attribute." do
          mnp = MemberNotificationPreference.new
          mnp.enabled = true
          mnp.enabled.should eq(true)
          mnp.enabled = false
          mnp.enabled.should eq(false)
        end

        it "\n #{nbr}: should show ALL Notification Types, even brand new ones the user has not previously seen." do
          #cleanup
          member_id = 10
          x = MemberNotificationPreference.get_all_for_member(member_id)
          # x.class.name.to_s eq("Array")
          # x[0].class.name.should eq(MemberNotificationPreference)
          x.length.should eq(2)
        end


        it "should have the same description as as the type" do
          type = NotificationType.find(1)
          MemberNotificationPreference.create(:enabled => false, :member_id => 5, :notification_type_id => type.id)
          pref = MemberNotificationPreference.where("member_id = ?", 5).first
          pref.description.should eq(type.description)     
        end
      end

    end

    context "administrator user experience" do

      #
    


    end

    context "system administrator user experience" do

      #
    end
  end  


  context "technical requirements"  do

    context "creating instances to be viewed (index)"  do


   

    end



  end


 
   

end

