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


  before_create { generate_token(:auth_token) }
  
  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end

  def  members
    
    ids = Array.new
    Member.where("email = ?", self[:email]).each do |member|
      ids << member.id
    end
    ids
  end


  def clubs
    
    mbrs = members    
    ids = Array.new
    mbrs.each do |member_id|
      member = Member.find(member_id)
      club = Club.find(member.club_id)
      ids << club.id
    end
    ids
  end




  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    UserMailer.password_reset(self).deliver
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
