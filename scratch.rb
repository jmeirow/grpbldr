

class Holder
  attr_accessor :key, :val

  def initialize (key, val)
    @key = key
    @val = val
  end

end



recs = Array.new
recs << Holder.new(1, "10:00 AM")
recs << Holder.new(2, "11:00 AM")
recs << Holder.new(3, "12:00 PM")
recs << Holder.new(4, "1:00 PM")


js = Array.new
recs.each { |rec|  js << "   #{rec.key}: '#{rec.val}'" }
puts "array=" +    "{ #{js.join(',') } }"

 


