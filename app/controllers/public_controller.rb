class PublicController < ApplicationController
  
	layout 'public'


  	def home
  	end

  	def tos
  	end
	 

	def club
		@club = Club.find(params[:club_id])
		render 
	end



end

