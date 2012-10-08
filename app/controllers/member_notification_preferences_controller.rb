class MemberNotificationPreferencesController < ApplicationController
  # GET /member_notification_preferences
  # GET /member_notification_preferences.json
  def index
    @member_notification_preferences = MemberNotificationPreference.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @member_notification_preferences }
    end
  end

  # GET /member_notification_preferences/1
  # GET /member_notification_preferences/1.json
  def show
    @member_notification_preference = MemberNotificationPreference.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @member_notification_preference }
    end
  end

  # GET /member_notification_preferences/new
  # GET /member_notification_preferences/new.json
  def new
    @member_notification_preference = MemberNotificationPreference.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @member_notification_preference }
    end
  end

  # GET /member_notification_preferences/1/edit
  def edit
    @member_notification_preference = MemberNotificationPreference.find(params[:id])
  end

  # POST /member_notification_preferences
  # POST /member_notification_preferences.json
  def create
    @member_notification_preference = MemberNotificationPreference.new(params[:member_notification_preference])

    respond_to do |format|
      if @member_notification_preference.save
        format.html { redirect_to @member_notification_preference, notice: 'Member notification preference was successfully created.' }
        format.json { render json: @member_notification_preference, status: :created, location: @member_notification_preference }
      else
        format.html { render action: "new" }
        format.json { render json: @member_notification_preference.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /member_notification_preferences/1
  # PUT /member_notification_preferences/1.json
  def update
    @member_notification_preference = MemberNotificationPreference.find(params[:id])

    respond_to do |format|
      if @member_notification_preference.update_attributes(params[:member_notification_preference])
        format.html { redirect_to @member_notification_preference, notice: 'Member notification preference was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @member_notification_preference.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /member_notification_preferences/1
  # DELETE /member_notification_preferences/1.json
  def destroy
    @member_notification_preference = MemberNotificationPreference.find(params[:id])
    @member_notification_preference.destroy

    respond_to do |format|
      format.html { redirect_to member_notification_preferences_url }
      format.json { head :no_content }
    end
  end
end
