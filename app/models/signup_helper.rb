require 'custom/system_services.rb'
require 'pry'
require 'pry_debug'


AVAILABLE_ONLY = "1"
ALL =  "2"


class SignupHelper
  include ActiveModel::Validations
  include SystemServices
  # modules
  include ActiveBuilder

  validate :at_least_one_checkbox_must_be_checked
   
  #
  # Instance methods here
  #

  def initialize(params, cache)
    @params = params
    @requested_information = SignupHelper.get_requested_information params, cache
    @cache = cache
  end

  def requested_information
    @requested_information
  end

  
  def  at_least_one_checkbox_must_be_checked
    if @params[:signup_ids].nil? && @params[:switch_ids].nil?
      errors.add(:at_least_one_signup_or_switch_request , 'must be checked.')
    end
  end

  def save
    if !valid?
      return false
    end

    unless @params[:signup_ids].nil?
      @params[:signup_ids].each do |id_pair| 
        ids = id_pair.split("_")

        if @params[:selected_member].nil? == false  &&  @params[:selected_member][:member_id] != ""  
            Assignment.create(:role_id => ids[1], :meeting_id => ids[0], :member_id => @params[:selected_member][:member_id] )
            

        else
          Assignment.create(:role_id => ids[1], :meeting_id => ids[0], :member_id => @params[:member_id])
        

        end
      end
    end

    true

  end

  def send_signup_email club
    Rails.logger.info("INSIDE OF send_signup_email.................................................")
    member_id = member_id_of_role_holder
    unless @params[:switch_ids].nil?
      @params[:switch_ids].each do |assignment_id|
        send_email('SwitchRequestMailerWorker',member_id,assignment_id, club)
      end
    end
    unless @params[:signup_ids].nil?
      @params[:signup_ids].each do |assignment_id|
        ids = assignment_id.split('_')
        send_email('RoleSignupNotificationMailerWorker',member_id,ids[0].to_i,ids[1].to_i, club)
      end
    end


  end

  def member_id_of_role_holder
    if @params[:selected_member].nil? == false  &&  @params[:selected_member][:member_id] != ""  
      @params[:selected_member][:member_id].to_i
    else
      @params[:member_id].to_i
    end
  end



  #
  # Class methods below
  #
 

  def self.initial_page_load?(params)
    params[:role].nil?
  end


  def self.specfic_role_selected?(params)
    params[:role].nil? == false && params[:role][:role_id] != ''
  end


  def self.all_roles_selected?(params)
    params[:role][:role_id] == ''
  end 


  def self.user_wants_to_see_all_occurrences?(params)
    params[:assignments] == ALL 
  end


  def self.selected_role_id(params)
    params[:role][:role_id].to_i
  end


  def self.user_has_submitted_request?(params)
    SignupHelper.check_that_param_is_hash params
    params[:commit].nil? == false && params[:commit] == 'Save Selection(s)'
  end


  def self.role_ids_from_signups(params)
    params[:signup_ids].collect { |x| x.split('_')[1]  }
  end


  def self.check_that_param_is_hash(params )
    true
  end


  def self.roles(params)
    SignupHelper.check_that_param_is_hash params 
    SignupHelper.check_params_contain_expected_values(params, [:signup_ids, :club_id])
    results = Array.new
    signup_ids = params[:signup_ids].collect { |x| x.split('_')[0]  }
    signup_ids.each do |role_id|
      results << Role.where("id = ? and club_id = ?", role_id.to_i, params[:club_id].to_i).first
    end
    results
  end


  def self.check_params_contain_expected_values(params, keys)
    result = true
    keys.each do |key|
      if params.include?(key) == false
        result = false
        break
      end
    end
    result
  end

  
  def self.get_requested_information (params,cache)
    # The purpose of this method is to return to the users a list of 
    # future meeting roles based on information the user has submitted.
    #
    # They can submit two different search criteria elements to influence 
    # the results displayed on the screen.
    #
    # The two search criteria they can choose from are:
    #
    #
    # 1. Role
    # 2. Open Assignments or All Assignments
    #
    # The 'role' dropdown provides a list of roles that the user can select from.
    # If they choose a specific role, then the params hash will contain
    # [:role][:role_id] where :[role_id] = the id of the selected role.
    # 
    # If they select 'All Roles' (the default), the params hash will contain
    # [:role][:role_id] where [:role_id] = ''
    #
    #
    # 
    # The 'Assignments' dropdown (Open Assignments and All Assignments) indicates
    # if the user should be shown ALL future meetings for the selected role type
    # (even if another member is currently assigned to that meeting/role), or if 
    # they only want to see 'available' opportunities to fill the role.
    #
    #
    #


    @club = Club.find(params[:club_id].to_i)
 

    if SignupHelper.initial_page_load? params
        params[:meeting_type_id] = @club.default_meeting_type_id.to_s
        @assignment_query_results = Assignment.available_assignments(params[:club_id].to_i, @club.default_meeting_type_id, cache)
    else
        if self.specfic_role_selected? params 
          if self.user_wants_to_see_all_occurrences? params
            @assignment_query_results = Assignment.all_assignments_for_role(SignupHelper.selected_role_id(params), params[:club_id].to_i, params[:meeting_type_id].to_i, cache)
          else
            @assignment_query_results = Assignment.available_assignments_for_role(SignupHelper.selected_role_id(params), params[:club_id].to_i, params[:meeting_type_id].to_i, cache) 
          end
        else
          if self.user_wants_to_see_all_occurrences? params
            @assignment_query_results = Assignment.all_assignments(params[:club_id].to_i, params[:meeting_type_id].to_i,cache) 
          else
            @assignment_query_results = Assignment.available_assignments(params[:club_id].to_i, params[:meeting_type_id].to_i,cache) 
          end
        end
      end
    end
    @assignment_query_results    
  end


  #
  #
  # These methods are used to determine what the user asked for
  # of if the page was just loaded and the user has not yet asked
  # for anything.
  #
  #





