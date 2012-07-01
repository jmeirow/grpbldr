class Event < ActiveRecord::Base
  attr_accessible :action, :club_id, :detail, :model, :transacted_by
end
