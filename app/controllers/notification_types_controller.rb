class NotificationTypesController < ApplicationController



  layout 'sysadmins' 



  # GET /notification_types
  # GET /notification_types.json
  def index
    @notification_types = NotificationType.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @notification_types }
    end
  end

  # GET /notification_types/1
  # GET /notification_types/1.json
  def show
    @notification_type = NotificationType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @notification_type }
    end
  end

  # GET /notification_types/new
  # GET /notification_types/new.json
  def new
    @notification_type = NotificationType.new
    @member = params[:member_id]
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @notification_type }
    end
  end

  # GET /notification_types/1/edit
  def edit
    @notification_type = NotificationType.find(params[:id])
  end

  # POST /notification_types
  # POST /notification_types.json
  def create
    @notification_type = NotificationType.new(params[:notification_type])

    respond_to do |format|
      if @notification_type.save
        format.html { redirect_to @notification_type, notice: 'Notification type was successfully created.' }
        format.json { render json: @notification_type, status: :created, location: @notification_type }
      else
        format.html { render action: "new" }
        format.json { render json: @notification_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /notification_types/1
  # PUT /notification_types/1.json
  def update
    @notification_type = NotificationType.find(params[:id])

    respond_to do |format|
      if @notification_type.update_attributes(params[:notification_type])
        format.html { redirect_to @notification_type, notice: 'Notification type was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @notification_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /notification_types/1
  # DELETE /notification_types/1.json
  def destroy
    @notification_type = NotificationType.find(params[:id])
    @notification_type.destroy

    respond_to do |format|
      format.html { redirect_to notification_types_url }
      format.json { head :no_content }
    end
  end
end
