require 'pry'
require 'pry_debug'



class ApplicationController < ActionController::Base
  
  protect_from_forgery
   

  helper_method :current_user , :current_user_admin?, :current_member, :current_club, :current_user_is_super_user?, :multiple_members?


  before_filter :check_web_status, :protect_against_url_tampering , :authorize, :set_values


  def authorize
    redirect_to new_session_url, alert: "Not authorized." unless allowed?
  end


  def allowed?
    if session[:user_id]
      return true
    else
      GenericLog.create(:information =>  "user_id not set in session ")
    end

    if allowed_path? request.fullpath  
      return true
    else
      GenericLog.create(:information =>  " not an allowed path...  ")
    end


    if /users/.match(request.fullpath)  
      return true 
    else
      GenericLog.create(:information =>  " not a 'users' path ")
    end
    false
  end


  def allowed_path? current_path

    # these paths ALLOW PUBLIC ACCESS
    return true if /log_in/.match current_path
    return true if /public/.match current_path
    return true if /sessions/.match current_path
    return true if /assets/.match current_path
    return true if /enrollments/.match current_path
    return true if /enrollments\/new/.match current_path
    return true if /enrollments\/create/.match current_path
    return true if /password_resets/.match current_path
    return true if /sign_up/.match current_path
    return true if /maintenance\/display_message/.match current_path
    GenericLog.create(:information =>  "failed path in 'allowed_path?' = #{current_path} ")
    false
  end


  def initalize
    session = nil
    super
  end


  def set_current_member
    LoggedInMember.current = current_member if current_member
  end


private     
  

  def set_values
    if session[:club_id]
       @club = current_club
       @member = current_member 
       @user = current_user 
    end
  end


  def check_web_status
    #return if request.env['REQUEST_URI'].include?("display_message")
    return if request.url.include?("display_message")

    config = SysConfiguration.where("config_key = ?", "web.status").first

    if (  config && 
          config.config_value == "down" &&    
          request.env['REQUEST_URI'].include?("configuration") == false &&   
          request.env['REQUEST_URI'].include?("bring_up")  == false  )
      
      redirect_to display_message_path 
    end
  end

  def multiple_members?
    session[:members] && session[:members].length > 1
  end


  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
    @current_user
  end


  def current_member

    @current_member ||= Member.find(session[:member_id]) if session[:member_id] 
    LoggedInMember.current = @current_member
    
  end


  def current_club
    @club = Club.find(current_member.club_id)
  end


  def protect_against_url_tampering
    req = Request.new
    req.ip_addr  = request.remote_ip.to_s
    req.page_uri = request.path
    req.save

    return if params[:club_id] && session[:clubs] && session[:clubs].include?(params[:club_id])

    if params[:user_id] && current_user.id != params[:user_id]
      render :template => "errors/422.html", :status => status, :layout => 'errors.html.erb'
      return
    end

    unless params[:club_id].nil?
      unless params[:club_id] == session[:club_id]
      end
    end
    if ! params[:club_id].nil? && ! params[:member_id].nil?
      x = Member.where("club_id = ? and id = ?", params[:club_id], params[:member_id])
      if (x.nil? || x.length == 0)
        render :template => "errors/422.html", :status => status, :layout => 'errors.html.erb'
      end
    end
  end
  

  def set_club
    if session[:user_id].nil?
      @club = Club.find(1)
    else
      @club = current_club
    end
  end

  
  def current_user_is_super_user?
    session[:logged_in_super_user].nil? == false &&  session[:logged_in_super_user] == ENV['GB_SUPER_USER_TOKEN'] 
  end

  
  def current_user_admin?
    session[:logged_in_admin].nil? == false && session[:logged_in_admin] == true
  end


end
