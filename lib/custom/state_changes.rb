
class StateChanges

  def initialize (before , after)
    @before = before
    @after = after
  end

  def added
    @after - @before
  end 

  def deleted 
    @before - @after
  end

end
