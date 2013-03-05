



class EnrollmentsController < ApplicationController
  



  def new
    @enrollment = Enrollment.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @new }
    end    
  end

  def create
    @enrollment = Enrollment.new(params[:enrollment])
    if @enrollment.valid?
      @enrollment.create_other_models
      redirect_to log_in_path, :notice => "Enrollment complete! You may now login with your email address and password."
    else
      render :action => 'new'
    end
  end
  
  def index
     render :action => 'new'
     return
  end
  

end
