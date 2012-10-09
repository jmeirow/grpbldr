class Event < ActiveRecord::Base


  
  # modules
  include ActiveBuilder

  #access
  attr_accessible :action, :club_id, :detail, :model, :transacted_by


  #callbacks  
  after_find :gb_set_attribute_methods_from_attributes

end