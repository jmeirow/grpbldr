

class TimeParser

  def parse(time)

    @error = 0

    parts = time.split(/[:\s]/)
  

    if parts.length != 3
      
      a = fix parts
      parts = a
    end
    if parts.nil? == true
     
      error
    else
      hours = parts[0]  
      minutes = parts[1]
      ampm = parts[2]

      if TimeParser.is_integer?(hours)  && TimeParser.is_integer?(minutes)
        
        if hours.to_i > 12 || hours.to_i < 1
          error
        end 
        if minutes.to_i < 0 || minutes.to_i > 59
          error
        end
        if ampm.upcase != "AM" && ampm.upcase != "PM"
          error
        end 
      else
        error
      end
    end

    parts unless @error > 0

  end

  private


  def error
    @error = @error + 1
  end

  def fix(parts)
    if parts.length == 2
      if (parts[1].upcase.end_with?("AM") || parts[1].upcase.end_with?("PM"))
        time = parts[0] + ":" + parts[1].upcase.chomp("AM").chomp("PM") + ' ' + parts[1].slice(parts[1].length-2, 2)
        time.split(/[:\s]/)
      end
    end
  end


  def self.is_integer?(s)
    s.to_s.match(/\A[+-]?\d+?(\d+)?\Z/) == nil ? false : true 
  end

end