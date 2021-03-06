require 'custom/system_services.rb'



class SessionsController < ApplicationController 

    include SystemServices
 
  def new

    @enrollement = Enrollment.new
  end

  
  def create

    reset_session

    user = User.authenticate(params[:email], params[:password])
      
    @user = user
    if user
      session[:user_id] = user.id 

      @members =  Member.where( "email = ? and ? between start_date and end_date", user.email, Time.now  ) 
      
      if @members.length == 0
        redirect_to root_url , :notice => 'You have not yet been added as a member to any club/organization within GroupBuilder. Please contact the administrator of your organization.'
        return
      end 

      if @members.length > 1 
        session[:clubs] = user.clubs
        session[:members] = @members.map {|x| x.id }
        render  :action => 'present'
      else
        session[:members] = @members.map {|x| x.id }
        establish_session @members[0] 
        redirect_to club_member_assignments_path(params[:club_id],@members.first), :notice => "Logged in!"
      end
    else

      current_uri = request.env['PATH_INFO']
      if current_uri.include? 'enrollments'
         #redirect_to enrollments_new_path
      else
         flash[:notice] =  "Invalid email or password."
        render "new" 
      end
    end
  end
   
  def destroy  
     reset_session
     redirect_to root_url, :notice => "Logged out!"  
  end

  def revoke_admin
    session.delete(:logged_in_admin)
    redirect_to club_member_assignments_path(current_club,current_member) 
  end

  def revoke_super_user
    session.delete(:logged_in_super_user) 
    redirect_to club_member_assignments_path(current_club, current_member)
  end


  def select
    if !params[:member_id] || params[:member_id] == ""
      user = User.find(session[:user_id]) 
      @members =  Member.where( "email = ? and ? between start_date and end_date", user.email, Time.now  )

      if @members.length > 1 
        session[:clubs] = user.clubs
        session[:members] = @members.map {|x| x.id }
        flash[:notice] = "You must select a club."
        render :action => 'present'
      end
    else
      @member = Member.find(params[:member_id])
      @club = Club.find(@member.club_id)
      establish_session(@member)
      redirect_to club_member_assignments_path(@club.id,@member.id), :notice => "Logged in!"
    end
  end


  private

  def establish_session(member)


    session[:email] = member.email
    session[:member_id] = member.id
    club = Club.find(member.club_id)
    params[:club_id] = club.id
    session[:club_id] = club.id
    session[:logged_in_admin] = Admin.where("email = ? and club_id = ?", member.email, session[:club_id]).count > 0
    session[:logged_in_super_user] =  (  member.email == ENV['GB_SUPER_USER_TOKEN'] ? member.email : nil )
    
    # In the near future this should be an event that an observer acts upon, sending an email,
    # or whatever else should be done when a user logs in.

    send_email('LoginMailerWorker',member.id, club)       

  end

end
  



























