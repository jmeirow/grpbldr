


require 'pp'


$list = Hash.new


final_results = Array.new

$list["even@grpbldr.com"] = %w( 2 4 6 8 10 12 14 16 18 20 )
$list["odd@grpbldr.com"] = %w( 1 3 5 7 9 11 13 15 17 19 bigodd@grpbldr.com )
$list["bigodd@grpbldr.com"] = %w(3333 5555 7777)
$list["primes@grpbldr.com"] = %w( 2 3 5 7 11 13 17 19 )
$list["prime_and_odd_and_big@grpbldr.com"] = %w( odd@grpbldr.com primes@grpbldr.com 1000 2000 3000 )


def get_members name_list, results
  interim = Array.new; groups = Array.new
  name_list.each do |name|
    interim   = $list[name]
    groups  += interim.select{|x| x.end_with? "@grpbldr.com" }
    results += interim.reject{|x| x.end_with? "@grpbldr.com" }
  end
  if groups.count > 0
    get_members groups, results
  else
    results
  end
end


final_results = get_members ["prime_and_odd_and_big@grpbldr.com"], final_results
puts 'RESULTS'
puts final_results.collect{|x| x.to_i}.sort.uniq


















