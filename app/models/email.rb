class Email < ActiveRecord::Base

  # modules
  include ActiveBuilder

  #access
  attr_accessible :body, :from, :subject, :to

  #callbacks
  after_find :gb_set_attribute_methods_from_attributes
  
end
