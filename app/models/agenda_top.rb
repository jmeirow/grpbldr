class AgendaTop < ActiveRecord::Base
  attr_accessible :agenda_definition_id, :body_text, :heading_text, :image_height, :image_source, :image_width
end
