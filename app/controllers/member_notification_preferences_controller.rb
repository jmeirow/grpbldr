class MemberNotificationPreferencesController < ApplicationController
  # GET /member_notification_preferences
  # GET /member_notification_preferences.json
  def index
    @member_notification_preferences = MemberNotificationPreference.get_all_for_member params[:member_id]



    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @member_notification_preferences }
    end
  end
 

  def update_email_preferences
    @member_notification_preferences = MemberNotificationPreference.where("member_id = ?",params[:member_id])


    @member_notification_preferences.each do |pref|
      pref.enabled = params["enabled_#{pref.id}".to_sym]
      @save_status = pref.save
      break if @save_status == false
    end

    respond_to do |format|
      if @save_status 
        format.html { redirect_to club_member_member_notification_preferences_path(params[:club_id],params[:member_id]), notice: 'Notifcation preference(s) successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :index }
        format.json { render json: @member_notification_preference.errors, status: :unprocessable_entity }
      end
    end
  end





end
