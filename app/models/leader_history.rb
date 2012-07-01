class LeaderHistory < ActiveRecord::Base
  attr_accessible :end_date, :leader_id, :member_id, :notes, :start_date
end
