class ContestSignup < ActiveRecord::Base
  attr_accessible :club_id, :member_id, :role_description


  def role_holder_name
    if self[:member_id].nil? == true
      name = 'OPEN'
    else
      if self[:role_description].downcase.match(/judge/)
        name = 'Anonymous'
      else
        name = Member.find(self[:member_id]).full_name
      end
    end

    name
  end


end
