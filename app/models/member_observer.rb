require './lib/custom/active_audit.rb'
class MemberObserver < ActiveRecord::Observer
  include ActiveAudit


  def after_create observed
    #nothing here yet
  end

  def after_update observed
    check_for_end_of_membership observed
  end


  #other models define their 'care-abouts' here for this model's events

  def check_for_end_of_membership observed
    if observed.changes[:end_date] && observed.changes[:end_date] != '12/31/9999'
      member = Member.find(observed.id)
      lists = DistList.where("club_id = ? and auto_delete = 'Y'", member.club_id)
      lists.each do |list|
        dist_list_member = DistListMember.where("member_id = ? and dist_list_id = ?", member.id, list.id).first
        DistListMember.delete(dist_list_member.id) if dist_list_member
      end
    end
  end

end