class PublicController < ApplicationController
  
	layout 'public'


  	def home
  	end

	def landing
  	end

	def inner
  	end

 	def jquery_ui

	end

	def club
		@club = Club.find(params[:club_id])
		render 
	end



end

