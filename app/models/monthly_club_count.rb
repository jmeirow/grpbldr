
require 'date'

class Calendar
	def initialize(date)
		@date = date
	end
	def date
		@date
	end
end

class Club
	attr_accessor :id, :club_start_date
	def initialize(id,*args)
		@id = id
		if args.length > 0
			@club_start_date = args[0]
		else
			@club_start_date = p('2011-06-15')
		end
	end
	def to_s
		puts "club id = #{id}, club start date = #{club_start_date}"
	end
end

$calendar = Calendar.new(Date.today)

class Agreement

	attr_accessor :from_date, :through_date, :club_monthly_rate, :member_monthly_rate
	
	def initialize(club,from_date,through_date, club_monthly_rate, member_monthly_rate)
		@club = club
		@from_date = from_date
	 	@through_date = through_date
	 	@club_monthly_rate = 	club_monthly_rate
	 	@member_monthly_rate = member_monthly_rate
	end

	def club_id
		@club.id
	end

	def membership_segments
		$clb_mbr_segs.select{  |segment| segment.club_id = @club.id }
	end

	def to_s
		puts "club_id = #{club_id}, begin date = #{from_date}, through date = #{through_date}"
	end

	def self.all_current_agreements
		# replace with A/R
		$agreements.select { |x| $calendar.date >= x.from_date && $calendar.date <= x.through_date}
	end

	def self.agreements_for_club(club)
		# replace with A/R
		$agreements.select { |x| x.club_id == club.id }
	end



end

def p(dt)
	Date.parse(dt)
end
 



def banner(title)
	puts "#-----------------------------------------------------------------------------"
	puts "   #{title}   "
	puts "#-----------------------------------------------------------------------------"	
	puts
end



# banner "Testing 'all_current_agreements'"
# Agreement.all_current_agreements.each do |agreement|
# 	puts agreement.to_s
# end

# banner "Testing 'agreements_for_club'"

# $clubx = Club.new(4)
# Agreement.agreements_for_club($clubx).each do |agreement|
# 	puts agreement.to_s
# end

class Member
	attr_accessor :club_id, :id
	def initialize(club,id)
		@id = id
		@club_id = club.id
	end
end


#initially, these will be constructed from Member objects in production
class ClubMembershipSegment
	attr_accessor :member_id, :club_id, :from_date, :through_date
	def initialize (member,*args)
	 	@member_id = member.id
	 	@club_id = member.club_id
		@from_date = args[0]
		if args.length == 2
			@through_date = args[1]
		else
			@through_date = p('9999-12-31')
		end
	end



end

class ClubMemberDetails
	attr_accessor  :period_start,:period_end

	def initialize(segment,agreement, period_start,period_end)
		@segment = segment
		@agreement = agreement
		@period_start = period_start
		@period_end = period_end
	end

	def is_full_month?
		@segment.from_date <= @period_start && @segment.through_date >= @period_end
	end

	def days_of_membership
	end
	def to_s
		"club_id #{@segment.club_id} member id = #{@segment.member_id} is full month? = #{is_full_month?}"
	end
end





$agreements = Array.new
$clb_mbr_segs = Array.new

$agreements << Agreement.new(Club.new(1),p("2012-01-01"),p("2012-12-31"), 5.00, 1.00 )

# a full month
$clb_mbr_segs << ClubMembershipSegment.new(Member.new(Club.new(1),100), p('2012-6-1'))
$clb_mbr_segs << ClubMembershipSegment.new(Member.new(Club.new(1),101), p('2012-7-15'))


Agreement.all_current_agreements.each do |agreement|
	agreement.membership_segments.each do |segment|
		details = ClubMemberDetails.new(segment, agreement,p('2012-07-01'),p('2012-07-31'))
		puts details.to_s
	end
end

 


























