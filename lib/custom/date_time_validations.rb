module DateTimeValidations

  def meeting_time_parseable

    p = TimeParser.new(meeting_time)
    return !errors.add(:meeting_time, 'is not a valid time.') unless p.valid?
  end

 
  def update_time

    p = TimeParser.new(meeting_time)
    if p
      self[:hour] = p.hour
      self[:minute] = p.minute
      self[:am_pm] = p.am_pm
    end
  end


  
end
