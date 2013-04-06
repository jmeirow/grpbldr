require 'date'
require 'pry'
require 'pry_debug'


class RecipientList 

  def initialize

    @polling_domain = ENV[MailUtility.GB_EMAIL_POLLING_DOMAIN]
  end


  def initialize(recipient_string)
    good_domains = filter_on_grpbldr_dot_com recipient_string
    well_formed = good_domains.select {|x| x.split('.').count == 2}
    valid_list_names =  well_formed.select { |x| known_handle?(x) && list_valid_for_handle?(x)  }
    @addresses = get_individual_addrs_for valid_list_names
  end


  def addresses

    @addresses.join(', ')
  end


  def filter_on_grpbldr_dot_com inbound_recipient_list 
    good = inbound_recipient_list.select {|x| x.downcase.end_with? "#{@polling_domain}" }
    good.collect { |x| x.split('@')[0] }
  end


  def known_handle? full_name 
    handle, list = full_name.split('.')
    %w(speakeasy northern).include? handle.downcase
  end


  def list_valid_for_handle? full_name
    handle, list = full_name.split('.').collect{|x| x.downcase }
    return true if %w(members leaders).include? handle 
    
    db = Hash.new
    db[:speakeasy] = %w(members )
    db[:northern] = %w(members )
    db[handle.to_sym].include? list.downcase
  end


  def get_individual_addrs_for good_names
    addrs = Array.new
    good_names.each do |name|
      handle, list = name.split('.')
      addrs += addrs_for handle, list
    end 
    addrs
  end


  def addrs_for handle, list
    club = Club.where("domain = ?", handle).first
    addrs = Array.new

    Member.where("club_id = ? and ? between start_date and end_date", club.id, Date.today ).each do |mem|
      puts "adding email address #{mem.email} to recipient list."
      addrs << mem.email
    end
    addrs 
  end

end




