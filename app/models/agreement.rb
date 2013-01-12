
class Agreement < ActiveRecord::Base

	# modules
	include ActiveBuilder

	#access
	attr_accessible :club_id, :club_monthly_rate, :from_date, :member_monthly_rate, :through_date

  




	#callbacks
	after_find :gb_set_attribute_methods_from_attributes
  



end
