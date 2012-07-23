
require 'date'
require 'flt'
include Flt



comment = <<END


	Assumed classes from existing system:
	Club, Member

	New classes not core to billing
	Calendar,  p(parse), DecNum


	Billing Classes

	Agreement
	ClubMembershipDetails
	MemberMonthlyTotals




	


END


 		DecNum.context.precision = 2

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
		
		$period_begin_date = p('2012-07-01') 
		$period_end_date = p('2012-07-31')

		class Member
			attr_accessor :club_id, :id
			def initialize(club,id)
				@id = id
				@club_id = club.id
			end
		end

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

			def agreement
				@agreement
			end

			def club_id
				@segment.club_id
			end

			def member_id
				@segment.member_id
			end

			def days_this_billing_period
				((@period_end - @period_start) + 1).to_i
			end

			def is_full_month?
				@segment.from_date <= @period_start && @segment.through_date >= @period_end
			end


		  #   MMMMMM
			#     PPPPPPPPPPPPP
		  #              MMMMMMMMMMM

			def days_of_membership
				if is_full_month?
					((@period_end - @period_start ) + 1).to_i
				else
					if (@segment.from_date >= @period_start && @segment.through_date <= @period_end)
						return ((@segment.through_date - @segment.from_date) + 1).to_i
					else
						if @period_start >= @segment.from_date
							return ((@segment.through_date - @period_start) + 1).to_i
						else
							return ((@period_end - @segment.from_date) + 1).to_i
						end
					end
				end

			end
			def to_s
				"club_id #{@segment.club_id} member id = #{@segment.member_id} is full month? = #{is_full_month?} days_of_membership = #{days_of_membership}"
			end
		end

		class MonthlyMemberTotal
			
			attr_reader :club_id, :member_id,   :membership_days_this_period, :agreement, :days_this_billing_period

			def initialize (club_id, member_id,is_full_month, membership_days_this_period, days_this_billing_period,agreement)
				@club_id = club_id
				@member_id = member_id
				@agreement = agreement
				@is_full_month = is_full_month
				@membership_days_this_period = membership_days_this_period
				@days_this_billing_period = days_this_billing_period

			end
			def is_full_month?
				@is_full_month
			end
			def charge_for_period
				if is_full_month?
					agreement.member_monthly_rate 
				else
					if @computed.nil?
						x = (agreement.member_monthly_rate / @days_this_billing_period)  *  @membership_days_this_period
						@computed = DecNum(x.to_s).round(2)
						@computed
					else 
						@computed
					end
		    end
		  end

			def to_s
				"Member:#{member_id} -  Days this period:#{membership_days_this_period} -   Amount: #{charge_for_period}"
			end
		end


		$agreements = Array.new
		$clb_mbr_segs = Array.new

		$agreements << Agreement.new(Club.new(1),p("2012-01-01"),p("2012-12-31"), 5.00, 1.00 )

		# a full month
			$clb_mbr_segs << ClubMembershipSegment.new(Member.new(Club.new(1),100), p('2012-6-1'))
			$clb_mbr_segs << ClubMembershipSegment.new(Member.new(Club.new(1),101), p('2012-7-15'))
			$clb_mbr_segs << ClubMembershipSegment.new(Member.new(Club.new(1),102), p('2012-6-15'), p('2012-07-10'))
			$clb_mbr_segs << ClubMembershipSegment.new(Member.new(Club.new(1),103), p('2012-7-10'), p('2012-07-16'))
			$clb_mbr_segs << ClubMembershipSegment.new(Member.new(Club.new(1),104), p('2012-7-1'), p('2012-07-31'))
			$clb_mbr_segs << ClubMembershipSegment.new(Member.new(Club.new(1),105), p('2012-6-1'), p('2012-06-30'))

			$clb_mbr_segs << ClubMembershipSegment.new(Member.new(Club.new(1),106), p('2012-7-1'), p('2012-7-7'))
			$clb_mbr_segs << ClubMembershipSegment.new(Member.new(Club.new(1),106), p('2012-7-15'), p('2012-7-21'))

			$clb_mbr_segs << ClubMembershipSegment.new(Member.new(Club.new(1),107), p('2012-7-1'), p('2012-7-7'))
			$clb_mbr_segs << ClubMembershipSegment.new(Member.new(Club.new(1),107), p('2012-7-8'))
			

		consolidated = Hash.new

		Agreement.all_current_agreements.each do |agreement|
			agreement.membership_segments.each do |segment|
				details = ClubMemberDetails.new(segment, agreement,p('2012-07-01'),p('2012-07-31'))
				if consolidated.has_key? details.member_id
					consolidated[details.member_id] << details
				else
					 consolidated[details.member_id] = [ details ]
				end
			end
		end


		$final_member_totals = Array.new

		keys = consolidated.keys
		keys.sort!
		keys.each do |member_id|
			details = consolidated[member_id]
			if details.length == 1 && details[0].is_full_month?
				detail = details[0]
				$final_member_totals << MonthlyMemberTotal.new(detail.club_id, detail.member_id,
															 detail.is_full_month?, detail.days_of_membership, detail.days_this_billing_period, detail.agreement)
			else
				detail = details[0]
				days = details.inject(0) { |sum,item| sum + item.days_of_membership }
				$final_member_totals << MonthlyMemberTotal.new(detail.club_id, detail.member_id,
															 (days == detail.days_this_billing_period) , days, detail.days_this_billing_period, detail.agreement)
			end
		end



		
		puts ""
		puts ""
		rec = $final_member_totals[0]
		puts "Club # #{rec.club_id} for the period of #{$period_begin_date} through #{$period_end_date} "

		$final_member_totals.each do |item|
			puts item.to_s if item.membership_days_this_period > 0
		end

		puts "------------------------------------------"
		total = $final_member_totals.inject(0) { |sum,item| sum + item.charge_for_period  }

		puts "TOTAL AMOUNT DUE:   #{ DecNum(total.to_s).round(2)  }"



 