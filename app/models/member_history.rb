class MemberHistory


  @segments = Array.new

  def initialize
    @segments = reload
  end

  def reload
    MemberHistorySegment.where("member_history_id = ? ", self[id:]
  end

  def current_member?
    current_segment.nil? ? false : true
  end

  def current_segement
    @segments.select { x | Date.today >= x.from_date && x.through_date <= Date.today }
  end


  def start(date)
    segment = current_segment
    if segment
      raise 'member is already active'
    else
      segment = MemberHistorySegment.new(Date.Today, Date.new("12/31/9999"), DateTime.now, self[:id] )
      segment.save
      @segments << segment
    end
  end

  def end(date)
    segment = current_segment
    if segment 
      segment.through_date = Date.today
      segment.save
      return true
    else
      raise 'member not currently active.'
    end
  end
end



class MemberHistorySegment

  attr_accessor :from_date, :through_date, :reported_date, :member_history_id

  def initialize (from_date, though_date, reported_date, member_history_id)
    @from_date = from_date
    @though_date = though_date
    @reported_date = reported_date
    @member_history_id = member_history_id
  end

end

