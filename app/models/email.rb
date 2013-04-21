 

class Email < ActiveRecord::Base

  # modules
  include ActiveBuilder

  #access
  attr_accessible :body, :from, :subject, :to, :cc, :bcc, :delivered_ts

  #callbacks
  after_find :gb_set_attribute_methods_from_attributes
  
end
