class NotificationType < ActiveRecord::Base
  attr_accessible :description, :mailer_type
end
