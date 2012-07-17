class UpdateClubEmailName < ActiveRecord::Migration
  def up

  	Club.all.each do |club|
  		club.email_name = club.id.to_s
  		club.save
  	end
  	

  end

 
end
