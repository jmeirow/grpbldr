require 'date'
# require 'pry'
# require 'pry_debug'


class RecipientList 

  def initialize

    @polling_domain = ENV[MailUtility.GB_EMAIL_POLLING_DOMAIN]
    puts "GB_EMAIL_POLLING_DOMAIN = #{@polling_domain}"
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
    Club.where("domain is not null").collect{|x| x.domain.downcase}.include? handle.downcase
  end


  def list_valid_for_handle? full_name
    handle, list = full_name.split('.').collect{|x| x.downcase}
    return true if %w(members).include? list.downcase 
    

    club = Club.where("domain = ?", handle).first
    DistList.where("club_id = ?",club.id ).collect{|x| x.name.downcase }.include? list.downcase
  end


  def get_individual_addrs_for good_names
    addrs = Array.new
    good_names.each do |name|
      handle, list = name.split('.').collect{|x| x.downcase}
      addrs += addrs_for handle, list
    end 
    addrs
  end


  def addrs_for handle, list
    club = Club.where("domain = ?", handle).first
    if club 
      addrs = Array.new
      if list == 'members'
        Member.where("club_id = ? and ? between start_date and end_date", club.id, Date.today ).each do |mem|
          addrs << mem.email
        end
        return addrs
      else
        dist_list = DistList.where("lower(name) = ? and club_id = ?", list, club.id).first
        if dist_list 
          ids = Array.new
          DistListMember.where("dist_list_id = ? ", dist_list.id).each{ |x|  ids << x.member_id }
          Member.find_all_by_id(ids).each  do |x| 
            addrs << x.email if (Time.now > x.start_date && Time.now < x.end_date) 
          end
          addrs
        else
          Mailman.logger.info "invaid dist_list name: #{list}"    # log bad list name
          []  # return empty list for bad list name
        end
      end
    else
       Mailman.logger.info "invalid club: #{handle}"  # log club not found here....
      [] # return empty list for bad club name
    end
  end

end




