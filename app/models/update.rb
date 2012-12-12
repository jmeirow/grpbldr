class Update < ActiveRecord::Base
  
  # modules
  include ActiveBuilder

  attr_accessible :description, :major, :minor, :patch, :release_date

  validates :release_date, :presence => :true


  def self.current
    update = Update.last
    if update
       "#{update.major.to_s}.#{update.minor}.#{update.patch}"
    else
      "0.0.0"
    end
  end
end
