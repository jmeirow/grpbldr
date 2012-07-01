require 'resolv'
 
  def validate_email_domain(email)
        domain = email.match(/\@(.+)/)[1]
        Resolv::DNS.open do |dns|
            @mx = dns.getresources(domain, Resolv::DNS::Resource::IN::MX)
        end
        @mx.size > 0 ? true : false
  end

  unless email.blank?
      unless email =~ /^[a-zA-Z][\w\.-]*[a-zA-Z0-9]@[a-zA-Z0-9][\w\.-]*[a-zA-Z0-9]\.[a-zA-Z][a-zA-Z\.]*[a-zA-Z]$/
          errors.add(:email, "Your email address does not appear to be valid")
      else
          errors.add(:email, "Your email domain name appears to be incorrect") unless validate_email_domain(email)
      end
  end

 
