class AgendaLineItem < ActiveRecord::Base
  

  # modules
  include ActiveBuilder

  #access
  attr_accessible :agenda_definition_id, :line_item_text, :person_display_name, :person_display_name_source, 
  :sequence_nbr, :time_format,:duration_in_minutes ,  :line_item_header , :include_in_agenda, :start_time, :end_time


  #callbacks
  after_find :gb_set_attribute_methods_from_attributes


  
  def resolved_person_display_name

  end

  def resolved_line_item_text

  end

  def resolved_line_item_head

  end
  

  def toggle_inclusion
  	if self[:include_in_agenda] == 'Yes'
  		self[:include_in_agenda] = 'No'
  	else
  		self[:include_in_agenda] = 'Yes'
  	end
  end

  def color
  	self[:include_in_agenda] == 'Yes' ? 'green' : 'gray'
  end

end
