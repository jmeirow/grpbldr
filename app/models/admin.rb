class Admin < ActiveRecord::Base
  include ActiveModel::MassAssignmentSecurity
  
   
  attr_accessible :email, :club_id 
   

end
