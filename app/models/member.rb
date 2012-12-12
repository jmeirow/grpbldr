class Member < ActiveRecord::Base




  #modules
  include ActiveBuilder


  # attributes allowed in mass-assignment
  attr_accessible :club_id, :first_name, :last_name, :start_date, :start_date_display, :end_date, :end_date_display, :assignable, :email, :address_one, :address_two, :city, :state, :zip_code, :phone, :mobile_phone
 

  #callbacks  
  after_find :gb_set_attribute_methods_from_attributes

  after_validation do
     @changes = self.changes.to_s
  end 
  after_save(:on => :create) do
    @event = Event.new(  :event => 'created', :model => 'Member', :detail => @changes    )
  end
  after_save(:on => :update) do
    @event = Event.create(  :event => 'updated', :model => 'Member', :detail => @changes    )
  end





  # associations
  belongs_to :club
  has_many :assignments
  has_many :absences


  # validations
  validates :first_name, :presence => true
  validates :last_name, :presence => true
  validates :email, :presence => true
  validate :start_date_display_parseable, :end_date_display_parseable, :end_date_gt_start_date


  # scopes
  scope :current, lambda { |club| where(" club_id = ? and ? between start_date and end_date", club.id, Date.today)  }
  scope :past,    lambda { |club| where(" club_id = ? and ? not between start_date and end_date", club.id, Date.today)  }
 

  def event
    @event
  end

 

 
  # virtual attributes

  def full_name
    "#{last_name}, #{first_name}"
  end

  def natural_name
    "#{first_name} #{last_name}"
  end 







  def self.current_members(club_id)
    Member.where("club_id = ? and ? between start_date and end_date", club_id, Date.today).order("last_name, first_name")
  end



  def self.send_mail(member,club,admin)
    if where("email = ?",member.email).length == 1
      MemberMailer.member_added(member,club,admin).deliver
      msg = "MemberMailer.member_added sent for #{member.email}.",member.email
    else
      msg = "MemberMailer.member_added skipped for #{member.email} because they already existed.", member.email
    end
    Event.create(:log => msg)
  end
end
