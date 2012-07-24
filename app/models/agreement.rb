class Agreement < ActiveRecord::Base
  attr_accessible :club_id, :club_monthly_rate, :from_date, :member_monthly_rate, :through_date
end
