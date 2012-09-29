

class NumberHelper



  def self.is_integer?(s)
    s.to_s.match(/\A[+-]?\d+?(\d+)?\Z/) == nil ? false : true 
  end


end
