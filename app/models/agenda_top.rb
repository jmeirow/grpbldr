class AgendaTop < ActiveRecord::Base


  # modules
  include ActiveBuilder

  #access
  attr_accessible :agenda_definition_id, :body_text, :heading_text, :image_height, :image_source, :image_width


  
  #callbacks
  after_find :gb_set_attribute_methods_from_attributes

  
end
