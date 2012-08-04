class SysConfiguration < ActiveRecord::Base

	
  # modules
  include ActiveBuilder

  #access
  attr_accessible :config_key, :config_value, :config_description


  #callbacks  
  after_find :gb_set_attribute_methods_from_attributes


end
