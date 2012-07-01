class Request < ActiveRecord::Base
  attr_accessible :ip_addr, :page_uri
end
