

class ActiveRecord::Base  
  def get_error_for_date (keyed, date_prop_symbol)
    return 'is required' if keyed.blank?
    return 'is not a valid date format.' unless !(self[date_prop_symbol] = Chronic.parse(keyed)).nil?
    return ''
  end
  
 
  
  def start_date_display
   	return start_date.strftime("%m/%d/%Y") unless start_date.blank?	
  end

  def start_date_display=(val)
   	self[:start_date_display], self[:start_date]  = val
   	@start_date_error_msg = get_error_for_date(val,:start_date)
  end

  def end_date_display
   	return end_date.strftime("%m/%d/%Y") unless end_date.blank?	
  end

  def end_date_display=(val)
   	self[:end_date_display], self[:end_date]  = val
   	@end_date_error_msg = get_error_for_date(val,:end_date)
  end

  # validators

  def start_date_display_parseable
       return !errors.add(:start_date, @start_date_error_msg) unless @start_date_error_msg.blank?
  end

  def end_date_display_parseable
     return !errors.add(:end_date, @end_date_error_msg) unless @end_date_error_msg.blank?  
  end








  def end_date_gt_start_date
    if !self[:start_date].blank? && !self[:end_date].blank?
      if ((self[:start_date] <=> self[:end_date]) > 0 )
        return !errors.add(:end_date,'cannot must be greater than Start date.')
      end
    end
    return true
  end  

end


