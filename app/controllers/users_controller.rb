class UsersController < ApplicationController
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      @members = Member.where("email = ?", @user.email)
       
  
      if @members.nil? || @members.length == 0
        @msg = 'Account successfully created. Please note that you have not yet been added to any organizations. You will be contacted via email each time an administrator adds you to a club.'
      else
        @msg = 'Account successfully created. You have been associated with the following club(s):'
        clubs = Array.new
        @members.each do |mbr|
          club = Club.find(mbr.club_id)
          clubs << club.name
        end
        club_names = clubs.join(",   ")
        @msg = @msg + club_names + ".  You may now sign into the system using the credentials you've just created."
      end     

      redirect_to root_url(:success =>'true'), :notice => @msg
    else
      render "new"
    end
  end


  # GET /members/1
  # GET /members/1.json
  def show

    layout 'application'
    @user = current_user

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

   # GET /users/1/edit
  def edit
    @user = current_user
  end
 
  def edit_password
    @user = current_user
  end

  def edit_email
    @user = current_user
  end



  # PUT /roles/1
  # PUT /roles/1.json
  def update_password
    @user = current_user
    @user.update_attributes_without_saving(params[:user])
    club = Club.find(session[:club_id])
    member = current_member #Member.find(session[:member_id])


    respond_to do |format|
      if @user.current_password_correct? && @user.password_and_confirmation?  && @user.save
        format.html { redirect_to club_member_assignments_path(club.id,member.id), :notice => 'Password change succeeded.' }
      else
        format.html { render action: "edit_password" }
      end
    end
  end




  def update_email
    @user = current_user
    @club = Club.find(session[:club_id])
    @member = Member.find(session[:member_id])
    @member.update_attribute(:email,params[:user][:email])
    @user.update_attribute(:email,params[:user][:email])
    respond_to do |format|
      if @user.save && @member.save
        format.html { redirect_to club_member_assignments_path(@club,@member), :notice => 'Email change succeeded.' }
      else
        format.html { render action: "edit_email" }
      end
    end
  end







end
