class User < ActiveRecord::Base

  # modules...

  include ActiveModel::MassAssignmentSecurity
  include User::Security 

  attr_accessible :email, :password, :password_confirmation , :current_password
  attr_accessor     :password, :password_confirmation, :current_password


  
  validates :email,  :presence => true, :on => :create
  validates_uniqueness_of :email
  validate :password_and_confirmation?,   :on => :create

  before_save :encrypt_password, :on => :create


  def  members
    ids = Array.new
    Member.where("email = ?", self[:email]).each do |member|
      ids << member.id
    end
    ids
  end


  def clubs
    ids = Array.new
    members.each do |member_id|
      member = Member.find(member_id)
      club = Club.find(member.club_id)
      ids << club.id
    end
    ids
  end

  

  
  # Class methods




  def self.authenticate(email,password)
     
    user = find_by_email(email)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password,user.password_salt)
      user
    else
      nil
    end
  end
  

    # instance methods

  def encrypt_password
    
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password,password_salt)
    end

  end
    
  def params
    @params = params
  end

end
