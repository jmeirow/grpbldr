class ApplicationController < ActionController::Base
  
  protect_from_forgery
   

  helper_method :current_user , :current_user_admin?, :current_member, :current_club, :current_user_is_super_user?, 
                :multiple_members? 


  before_filter :protect_against_url_tampering  , :check_web_status




def initalize
  session = nil
  super
end


private     



  






  def check_web_status
     
    return if request.env['REQUEST_URI'].include?("display_message")

    config = SysConfiguration.where("config_key = ?", "web.status").first

    if    config && 
          config.config_value == "down" &&    
          request.env['REQUEST_URI'].include?("configuration") == false &&   
          request.env['REQUEST_URI'].include?("bring_up")  == false  
      
          redirect_to display_message_path
    end
  end

  def multiple_members?
    session[:members] && session[:members].length > 1
  end

  def current_user
     
    if session[:user_id].nil?
      return User.find(1)
    else
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
      @current_user
    end
  end
  
  def current_member
     #return if current_user.nil?
      
     Member.find(session[:member_id])
  end

  def current_club
 
    if session[:user_id].nil?
      @club = Club.find(1)
    else
      Club.find(current_member.club_id)
    end  
  end

  def protect_against_url_tampering

    req = Request.new
    req.ip_addr  = request.remote_ip.to_s
    req.page_uri = request.path
    req.save


    return if params[:club_id] && session[:clubs] && session[:clubs].include?(params[:club_id])


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
       session[:logged_in_super_user].nil? == false &&  session[:logged_in_super_user] == ENV['SUPER_USER_TOKEN'] 
  end


  
  def current_user_admin?
    session[:logged_in_admin].nil? == false && session[:logged_in_admin] == current_member.email
  end








  
  
end
