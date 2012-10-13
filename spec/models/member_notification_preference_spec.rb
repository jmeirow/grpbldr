require 'spec_helper'


$mbr = 0
def mbr
  $mbr = $mbr + 1
end


describe MemberNotificationPreference do

  context "End-user requirements:" do

    context "When:" do 

      context "Viewing a Member Notification Preference on the members prefences page" do
  
        # 
      
        it "#{mbr}: should have a user-friendly description of the notification type." do
          mnp = MemberNotificationPreference.new
          mnp.description = "some text"
          mnp.description.should eq("some text")
        end

        it "#{mbr}: should have an 'enabled' attribute." do
          mnp = MemberNotificationPreference.new
          mnp.enabled = true
          mnp.enabled.should eq(true)
          mnp.enabled = false
          mnp.enabled.should eq(false)
        end

        it "#{mbr}: should show ALL Notification Types, even brand new ones the user has not previously seen." do
          
          member_id = 10
          x = MemberNotificationPreference.get_all_for_member(member_id)
          x.class.name.to_s eq("Array")

          x[0].class.name.should eq(MemberNotificationPreference)

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

