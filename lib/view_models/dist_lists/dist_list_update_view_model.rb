# require 'pry'
# require 'pry_debug'


class DistListUpdateViewModel 

   
  def self.get dist_list_id

    dist_list = DistList.find(dist_list_id.to_i)


    current_members = Member.where("club_id = ?   and CURRENT_DATE between start_date and end_date", dist_list.club_id ).order("last_name, first_name")

    list_members = DistListMember.where("dist_list_id = ?", dist_list_id.to_i).collect {|x| x.member_id}
    
    dist_lists = DistList.where("club_id = ?", dist_list.club_id).order("name")

    return dist_list, current_members, list_members, dist_lists

  end
end
