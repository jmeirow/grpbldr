module User::Security


  def current_password_correct?

    user = User.find(self.id)
    
    if current_password.blank?
      errors[:current_password] = " is required."
    else
       
      entered_password_hash = BCrypt::Engine.hash_secret(current_password,user.password_salt)
      if entered_password_hash != user.password_hash
        errors[:current_password] = " is not correct."
      end
    end
    return errors.count == 0
  end

  def update_attributes_without_saving(params)
    
    self.current_password = params[:current_password]
    self.password = params[:password]
    self.password_confirmation = params[:password_confirmation]
  end

  def password_and_confirmation?
    if self.password.blank?
      errors[:password] = " is required."
    end
    if self.password_confirmation.blank?
      errors[:password_confirmation] = " is required."
    end
    if self.password != self.password_confirmation
      errors[:password_and_password_confirmation] = " do not match."
    end

    return errors.count == 0
 
  end




  
end
