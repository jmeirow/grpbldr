class NotificationType < ActiveRecord::Base
    # modules
  include ActiveBuilder
  attr_accessible :description, :mailer_type

end
