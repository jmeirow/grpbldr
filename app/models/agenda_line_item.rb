class AgendaLineItem < ActiveRecord::Base
  

  # modules
  include ActiveBuilder

  #access
  attr_accessible :agenda_definition_id, :line_item_text, :person_display_name, :person_display_name_source, 
  :sequence_nbr, :time_format,:duration_in_minutes ,  :line_item_header , :include_in_agenda, :start_time, :end_time


  #callbacks
  after_find :gb_set_attribute_methods_from_attributes


  validates :line_item_header, :presence => true
  validates :duration_in_minutes, :presence => true,  :numericality => { :only_integer => true, :greater_than_or_equal_to => 0 }



  def agenda=(parent)
    @agenda = parent 
  end
  def agenda
    @agenda
  end



  
  def resolved_person_display_name
      if person_display_name_source == 'Static Text'
        person_display_name
      else
        agenda.member_for(person_display_name)
      end
  end

  def resolved_line_item_text
    agenda.resolved_line_item_text line_item_text
  end

  def resolved_line_item_head
    agenda.resolved_line_item_head line_item_header
  end

  def printed_start_time
    start_time if time_format == 'Start Time'
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
