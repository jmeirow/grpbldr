class Member < ActiveRecord::Base


  attr_accessible :first_name, :last_name, :start_date, :start_date_display, 
  :end_date, :end_date_display, :assignable, :email, :club_id, :address_one, :address_two, :city, :state, :zip_code, :phone, :mobile_phone
  
   

  belongs_to :club

  has_many :assignments
  has_many :absences
  
  
  validates :first_name, :presence => true
  validates :last_name, :presence => true
  validates :email, :presence => true
  
  validate :start_date_display_parseable, :end_date_display_parseable, :end_date_gt_start_date

  def full_name
    "#{last_name}, #{first_name}"
  end
  
  # def self.current_member
  #   #return Member.where("email = ?, club_id = ?",  current_user.email, session[:club_id])

  # end

  def event
    @event
  end


  after_validation do
     @changes = self.changes.to_s
  end 
  after_save(:on => :create) do
    @event = Event.new(  :event => 'created', :model => 'Member', :detail => @changes    )
  end
  after_save(:on => :update) do
     
    @event = Event.create(  :event => 'updated', :model => 'Member', :detail => @changes    )
  end

  
  def self.send_mail(member)
    if where("email = ?",user.email).length == 1
      
      club = Club.where("email = ?", member.email).first
      admin = Member.where('email = ? and club_id = ?', member.email,club.id)
      
      MemberMailer.member_added(member,admin).deliver
      msg = "MemberMailer.member_added sent for #{user.email}.",user.email
    else
      msg = "MemberMailer.member_added skipped for #{user.email} because they already existed.", user.email
    end
    EventLog.create(:log => msg)
  end
  
  
end
