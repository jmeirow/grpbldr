  class DistList < ActiveRecord::Base
  attr_accessible :active, :club_id, :description, :name, :auto_delete

  validates :name , :presence => true
  validates :name, :uniqueness => { :case_sensitive => false, :scope => :club_id, :message => "There is already a distribution list with this name." }
  validate  :no_blanks_in_name
  validate  :no_periods_in_name

  def no_blanks_in_name
	if self[:name].include? ' '
      errors[:name] << 'Distribution List name cannot contain blanks.'
    end
  end
  def no_periods_in_name
	if self[:name].include? '.'
       errors[:name] << "Distribution List name cannot contain periods ('.')"
    end
  end

end
