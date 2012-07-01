class RunningTime
  def initialize(hour,minute )
    @hour = hour
    @minute = minute
  end
  def +(minutes)

    @minute += minutes
    @hour += @minute / 60
    @hour %= 24 
    @minute %= 60
    to_s
  end
  def to_s
    am_pm = 'AM' if  (0..11) === @hour
    am_pm = 'PM' if  (12..23) === @hour
    if @hour > 12
      hour = @hour -12
    else
      hour = @hour
    end
    hour = 12 if hour == 0
    hour.to_s + ':' +  "%02d" % @minute.to_s  + ' ' + am_pm
  end
end
