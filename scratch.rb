


require 'benchmark'
require 'date'



# def test
#   first_single_select = nil
#   second_single_select = nil
#   select_seventeen = nil
#   Benchmark.bm do |x|
#     x.report { select_seventeen = Meeting.where("club_id = 6 and meeting_date > '2012/06/01'") }
#     puts "======================="
#     x.report { first_single_select = Meeting.where("id = 6") }
#     puts "======================="
#     x.report { second_single_select = Meeting.where("id = 6") }
#   end

#   puts "r2 length = #{r2.length}"
#   puts "r1 length = #{r1.length}"
#   puts "r3 length = #{r3.length}"
# end


class SomeClass
 

  def some_meth  options={}
    options.keys.each do |key|
      puts "#{key} = #{options[key]}"
    end
  end
end


x = SomeClass.new
#x.some_meth options={ :arg1 => "value1" }
#x.some_meth options={ :arg2 => "value2", :arg3 => "value3" } 
x.some_meth

