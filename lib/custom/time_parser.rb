class TimeParser

  attr_reader :hour, :minute, :am_pm, :to_s 

  def initialize time
    matched = /(1[012]|^[1-9]):[0-5][0-5] (am|pm|AM|PM)/.match(time.lstrip.squeeze(' '))
    if matched
      @valid = true
      parts = matched[0].split(/[\s:]/)
      

      @to_s = matched[0]
      @hour = parts[0].to_i
      @minute = parts[1].to_i 
      @am_pm = parts[2]
    else
      @valid = false
    end
  end


  def valid?
    @valid
  end
end


