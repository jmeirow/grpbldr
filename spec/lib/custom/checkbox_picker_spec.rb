




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


class ParamsToArray 
  def self.do prefix, params 
    params.keys.select { |param| param.start_with? prefix }.
      collect { |matched_param| matched_param.gsub(/#{prefix}/,'').to_i }
  end
end





describe StateChanges, " a class that accepts a 'new' array and an 'old' array and provdes  a 'deteted' array and an 'added' array to represent the change in state." do 



  it " should exist " do 
    x = StateChanges.new(Array.new, Array.new)
    x.class.should eq(StateChanges)
  end

  it "should have two attributes, 'added'. " do 
    x = StateChanges.new(Array.new, Array.new)
    x.respond_to?('added').should be_true
  end 


  it "should have two attributes, 'deleted'. " do 
    x = StateChanges.new(Array.new, Array.new)
    x.respond_to?('deleted').should be_true
  end 

  it "added should return an array " do 
    x = StateChanges.new(Array.new, Array.new)
    x.added.class.should eq(Array)
  end 

 
  it "deleted should return an array " do 
    x = StateChanges.new(Array.new, Array.new)
    x.deleted.class.should eq(Array)
  end 

  it "should accept two parameters to the constructor  "  do 
    x = StateChanges.new(Array.new, Array.new)
  end

  it "added should return elements in new_ary that do not exist in old_ary  "  do 
    x = StateChanges.new([], [1])
    x.added.should eq([1])
  end

  it "deleted should return elements in old_ary that do not exist in new_ary  "  do 
    x = StateChanges.new([1], [])
    x.deleted.should eq([1])
  end


end



describe ParamsToArray, "xx   " do    

  it "xx" do
    params = {  "tm_1" => "1" , "tm_5" => "z"    }
    ParamsToArray.do('tm_', params ).should eq([1,5])
  end

end
